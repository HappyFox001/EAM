import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import '../models/contract_command.dart';
import '../services/wallet_service.dart';
import 'dart:convert';

class TransactionDialog extends StatefulWidget {
  final ContractCommand command;

  const TransactionDialog({
    super.key,
    required this.command,
  });

  @override
  State<TransactionDialog> createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  bool _isLoading = false;
  TransactionResult? _result;

  Future<void> _executeTransaction() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final parameters = widget.command.parameters.values.map((param) {
        // Convert string addresses to EthereumAddress objects
        if (param is String && param.startsWith('0x') && param.length == 42) {
          return EthereumAddress.fromHex(param);
        }
        // Convert numeric strings to BigInt
        if (param is String) {
          try {
            // Remove any whitespace and handle scientific notation
            final cleanParam = param.trim().replaceAll(RegExp(r'\s+'), '');
            if (RegExp(r'^-?\d+(\.\d+)?([eE][+-]?\d+)?$')
                .hasMatch(cleanParam)) {
              return BigInt.parse(cleanParam);
            }
          } catch (e) {
            print('Error converting numeric parameter: $e');
          }
        }
        return param;
      }).toList();

      // 设置要发送的 ETH 数量（0.01 ETH）
      final value = widget.command.value;
      print("value in wei: $value");
      final functionAbi = jsonEncode(widget.command.functionAbi.toJson());

      final result = await WalletService().executeContractTransaction(
        contractAddress: widget.command.contractAddress,
        functionName: widget.command.functionAbi.name,
        parameters: parameters,
        value: value,
        functionAbi: functionAbi,
      );

      setState(() {
        _result = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _result = TransactionResult(
          success: false,
          error: e.toString(),
        );
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _executeTransaction();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isLoading) ...[
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8B7EF8)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Transaction Execution',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please wait for the transaction confirmation',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ] else if (_result != null) ...[
              Icon(
                _result!.success ? Icons.check_circle : Icons.error,
                color: _result!.success
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFF44336),
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                _result!.success
                    ? 'Transaction Executed Successfully'
                    : 'Transaction Execution Failed',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _result!.formattedResult,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                backgroundColor: const Color(0xFF8B7EF8),
              ),
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
