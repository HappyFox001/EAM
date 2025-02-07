#!/bin/bash
project_path='project'
collection_name='EAM_collection'
tokenizer='tokenizer'
model='model/bert'
input='_getRandomBurnAmount'
rebuild_mode=0
search_mode=1
python extract_function.py \
--project_path $project_path \
--collection_name $collection_name \
--tokenizer $tokenizer \
--model $model \
--input $input \
--rebuild_mode $rebuild_mode \
--search_mode $search_mode
