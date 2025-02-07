import os
import pdb
import subprocess
import re
import pandas as pd
import numpy as np
from gensim.models import KeyedVectors
import json
from pymilvus import MilvusClient
from pymilvus import connections, utility
from pymilvus import FieldSchema, CollectionSchema, DataType, Collection
import hashlib
import tqdm
from transformers import BertTokenizer, BertModel
import torch
import argparse
key_dict = {'id':'id','vector':'vector','code':'code','tag':'tag'}

def generate_id_from_code(code):
    """
    根据代码生成唯一的ID。
    使用SHA-256算法对输入的代码进行哈希处理,并截取前16个字符作为ID。
    :param code: 代码字符串
    :return: 哈希值作为字符串形式的ID
    """
   # 对输入的代码进行SHA-256哈希处理
    hash_object = hashlib.sha256(code.encode())
    # 获取哈希值的十六进制表示，并截取前16个字符
    hex_dig = hash_object.hexdigest()[:16]
    # 将截取的十六进制字符串转换为整数
    int_value = int(hex_dig, 16)
    if int_value > 9223372036854775807 or int_value < -9223372036854775808:
        int_value = int_value % 9223372036854775808
    return int_value


def get_solidity_version(file_path):
    """
    从给定的Solidity文件中提取Solidity编译器版本。
    
    :param file_path: Solidity文件(.sol)的路径
    :return: 提取的Solidity版本字符串，如果没有找到则返回None
    """
    pragma_pattern = re.compile(r"pragma\s+solidity\s+([^;]+);", re.IGNORECASE)
    
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()
        match = pragma_pattern.search(content)
        if match:
            return match.group(1).strip()[1:]
        else:
            return None

def change_solc_version(version):
    """
    更改solc-select使用的Solidity编译器版本。
    
    :param version: 要切换到的目标Solidity版本号，如"0.7.6"
    """
    try:
        # 使用solc-select选择指定版本
        result = subprocess.run(['solc-select', 'use', version], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print(f"已成功切换至Solidity版本 {version}")
    except subprocess.CalledProcessError as e:
        print("版本切换失败：")
        print("stdout:", e.stdout.decode())
        print("stderr:", e.stderr.decode())
     
def extract_functions_from_file(file_path):
    # 用于存储所有找到的函数内容
    # 正则表达式，用于匹配函数定义的开头
    func_start_regex = re.compile(r'^\s*function\s+_?[a-zA-Z0-9]+\s*$.*$\s*(internal|external|public|private)\s*(view|pure)?\s*{?') 
    with open(file_path, 'r') as file:
        lines = file.readlines()
        functions = []
        functions_content = []
        inside_function = False
        brace_counter_flag = False
        brace_counter = 0
        for line in lines:
            if 'function' in line :
                inside_function = True
                if line.count('{'):
                    brace_counter_flag = True
                brace_counter += line.count('{')  # 更新花括号计数器
                functions_content.append(line)
            elif inside_function:
                functions_content.append(line)
                if line.count('{'):
                    brace_counter_flag = True
                functions_content[-1] += line
                brace_counter += line.count('{') - line.count('}')  # 更新花括号计数器
                # 检查是否到达函数结尾
                if brace_counter_flag and brace_counter == 0:
                    inside_function = False
                    brace_counter_flag = False
                    functions.append(' '.join(functions_content))
                    functions_content = []
    
    return functions
     
def split_tag(text,tokenizer):
    # 使用正则表达式找到大写字母前的位置并插入空格，同时保留下划线
    return tokenizer(text, return_tensors='pt')

def get_tag_embedding(function_tag,model):
    with torch.no_grad():
        outputs = model(**function_tag)
        last_hidden_states = outputs.last_hidden_state
        cls_embedding = last_hidden_states[:, 0, :].squeeze()
    return cls_embedding.numpy().tolist()
        
def set_up_Milvus(collection_name,rebuild_mode):
    client = MilvusClient("model/RAG.db")
    
    fields = [
    FieldSchema(name=key_dict['id'], dtype=DataType.INT64, is_primary=True),
    FieldSchema(name=key_dict["vector"], dtype=DataType.FLOAT_VECTOR, dim=768),
    FieldSchema(name=key_dict["code"], dtype=DataType.VARCHAR, max_length=20000),  # 根据需要调整max_length
    FieldSchema(name=key_dict["tag"], dtype=DataType.VARCHAR, max_length=50)   # 示例
]   
    index_params = MilvusClient.prepare_index_params()
    index_params.add_index(
            field_name=key_dict["vector"],
            metric_type="COSINE",
            index_type="IVF_FLAT",
            index_name="vector_index",
            params={ "nlist": 128 }
        )
    schema = CollectionSchema(fields, "Collection for EAM")
    if rebuild_mode:
        client.drop_collection(collection_name=collection_name)
    client.create_collection(collection_name=collection_name,schema=schema,)
    client.create_index(collection_name=collection_name,index_params=index_params)
    return client,key_dict
    
def insert_vectors_to_Milvus(client, insert_data,collection_name):
    insert_data[key_dict['id']] = generate_id_from_code(insert_data[key_dict['code']])
    
    vectors = insert_data[key_dict['vector']]
    if not (isinstance(vectors, list) and len(vectors) == 768 and all(isinstance(v, float) for v in vectors)):
        raise ValueError("All vectors must be lists of 768 floats.")    
    if not isinstance(insert_data[key_dict['id']], int):
        raise TypeError(f"ID {insert_data[key_dict['id']]} is not of integer type.")
    if not (-9223372036854775808 <= insert_data[key_dict['id']] <= 9223372036854775807):
        raise ValueError(f"ID {insert_data[key_dict['id']]} is out of int64 range.")
    client.insert(
    collection_name=collection_name,
    data=insert_data,
    )   
    client.flush(collection_name)
    
def rebuild_database(project_path,client,collection_name,tokenizer,model):
    pattern = r"function\s+(\w+)\s*\("
    for root, dirs, files in tqdm.tqdm(os.walk(project_path)):
        for file in files:
            if file.endswith(".sol"):
                file_path = os.path.join(root, file)
                functions = extract_functions_from_file(file_path)
                sol_data = {key_dict['code']:[],key_dict['tag']:[],key_dict['vector']:[]}
                for function in functions:
                    match = re.search(pattern, function)
                    if match:
                        function_name = match.group(1)
                        function_tag = split_tag(function_name,tokenizer)
                        tag_embedding = get_tag_embedding(function_tag,model)
                        sol_data[key_dict['code']] = function
                        sol_data[key_dict['tag']]= function_name
                        sol_data[key_dict['vector']]= tag_embedding
                        insert_vectors_to_Milvus(client, sol_data, collection_name)

                    # pdb.set_trace()
  
def search_for_code(input,client,model,tokenizer,collection_name):   
    tokens = split_tag(input,tokenizer)
    query_vectors = get_tag_embedding(tokens,model) 
    res = client.search(collection_name=collection_name,data=[query_vectors],limit=2,search_params = {"metric_type": "COSINE"},output_fields=[key_dict['tag'], key_dict['code']],)
    print(res)    
      
if __name__ == '__main__':   
    parser = argparse.ArgumentParser(description="Search for code using Milvus.")
    parser.add_argument('--input', type=str, required=True, help='Input text to search for')
    parser.add_argument('--collection_name', type=str, required=True, help='Name of the collection to search in')
    parser.add_argument('--model', type=str, required=True, help='Path or name of the embedding model')
    parser.add_argument('--tokenizer', type=str, required=True, help='Path or name of the tokenizer')
    parser.add_argument('--project_path', type=str, default='project')
    parser.add_argument('--rebuild_mode', type=int,required=True, help='Rebuild the database')
    parser.add_argument('--search_mode', type=int,required=True, help='Search for code')
    args = parser.parse_args()
    tokenizer = BertTokenizer.from_pretrained(args.tokenizer)
    model = BertModel.from_pretrained(args.model)
    prompt = args.input
    client,key_dict = set_up_Milvus(args.collection_name,args.rebuild_mode)
    if args.rebuild_mode:
        rebuild_database(args.project_path,client,args.collection_name,tokenizer,model)
    if args.search_mode:
        search_for_code(prompt,client,model,tokenizer,args.collection_name)