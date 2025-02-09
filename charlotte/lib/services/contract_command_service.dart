import 'dart:convert';
import '../models/contract_command.dart';

class ContractCommandService {
  static final ContractCommandService _instance =
      ContractCommandService._internal();
  factory ContractCommandService() => _instance;
  ContractCommandService._internal();

  List<ContractCommand> parseCommands(String jsonString) {
    try {
      final Map<String, dynamic> data = json.decode(jsonString);
      final List<dynamic> commandsJson = data['commands'];
      return commandsJson
          .map((commandJson) => ContractCommand.fromJson(commandJson))
          .toList();
    } catch (e) {
      print('Error parsing commands: $e');
      return [];
    }
  }

  Future<List<ContractCommand>> processUserInput(String userInput) async {
    const testJson = '''
    {
      "commands": [
        {
          "command_id": "transfer_eth",
          "contract_address": "0x5E137EF828C5066fe33016F178d5832e5904430A",
          "function_abi": {
            "inputs": [],
            "name": "transfer",
            "outputs": [],
            "stateMutability": "payable",
            "type": "function"
          },
          "parameters": {},
          "value": "5000000000000000",
          "execution_description": "Transfer 0.005 ETH on the Sepolia testnet",
          "security_audit": {
            "risk_level": "low",
            "audit_notes": "Simple ETH transfer, amount is reasonable"
          }
        }
      ]
    }
    ''';

    return parseCommands(testJson);
  }

  // Future<bool> executeCommand(ContractCommand command) async {
  //   try {
  //     // TODO: 实现实际的合约调用逻辑
  //     print('Executing command: ${command.commandId}');
  //     print('Contract address: ${command.contractAddress}');
  //     print('Function: ${command.functionAbi.name}');
  //     print('Parameters: ${command.parameters}');
  //     return true;
  //   } catch (e) {
  //     print('Error executing command: $e');
  //     return false;
  //   }
  // }
}
