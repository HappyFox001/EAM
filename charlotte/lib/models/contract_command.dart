class ContractCommand {
  final String commandId;
  final String contractAddress;
  final ContractFunction functionAbi;
  final Map<String, dynamic> parameters;
  final BigInt value;
  final String executionDescription;
  final SecurityAudit securityAudit;

  ContractCommand({
    required this.commandId,
    required this.contractAddress,
    required this.functionAbi,
    required this.parameters,
    required this.value,
    required this.executionDescription,
    required this.securityAudit,
  });

  factory ContractCommand.fromJson(Map<String, dynamic> json) {
    return ContractCommand(
      commandId: json['command_id'],
      contractAddress: json['contract_address'],
      functionAbi: ContractFunction.fromJson(json['function_abi']),
      parameters: json['parameters'],
      value: BigInt.parse(json['value']),
      executionDescription: json['execution_description'],
      securityAudit: SecurityAudit.fromJson(json['security_audit']),
    );
  }

  String getFormattedDetails() {
    return '''Contract Address: $contractAddress
Function Name: ${functionAbi.name}
Parameters: $parameters''';
  }

  String getSecurityAuditDetails() {
    return '''Security Level: ${securityAudit.riskLevel}
Audit Notes: ${securityAudit.auditNotes}''';
  }
}

class ContractFunction {
  final List<FunctionParameter> inputs;
  final String name;
  final List<FunctionParameter> outputs;
  final String stateMutability;
  final String type;

  ContractFunction({
    required this.inputs,
    required this.name,
    required this.outputs,
    required this.stateMutability,
    required this.type,
  });

  factory ContractFunction.fromJson(Map<String, dynamic> json) {
    return ContractFunction(
      inputs: (json['inputs'] as List)
          .map((input) => FunctionParameter.fromJson(input))
          .toList(),
      name: json['name'],
      outputs: (json['outputs'] as List)
          .map((output) => FunctionParameter.fromJson(output))
          .toList(),
      stateMutability: json['stateMutability'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inputs': inputs.map((input) => input.toJson()).toList(),
      'name': name,
      'outputs': outputs.map((output) => output.toJson()).toList(),
      'stateMutability': stateMutability,
      'type': type,
    };
  }
}

class FunctionParameter {
  final String name;
  final String type;

  FunctionParameter({
    required this.name,
    required this.type,
  });

  factory FunctionParameter.fromJson(Map<String, dynamic> json) {
    return FunctionParameter(
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
    };
  }
}

class SecurityAudit {
  final String riskLevel;
  final String auditNotes;

  SecurityAudit({
    required this.riskLevel,
    required this.auditNotes,
  });

  factory SecurityAudit.fromJson(Map<String, dynamic> json) {
    return SecurityAudit(
      riskLevel: json['risk_level'],
      auditNotes: json['audit_notes'],
    );
  }
}
