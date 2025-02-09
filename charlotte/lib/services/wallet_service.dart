import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:hex/hex.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

class WalletService {
  static final WalletService _instance = WalletService._internal();
  factory WalletService() => _instance;
  WalletService._internal();

  Credentials? _credentials;
  String? _privateKey;
  String? _publicKey;
  Web3Client? _web3client;

  // 获取凭证
  Credentials? get credentials => _credentials;

  // 获取私钥
  String? get privateKey => _privateKey;

  // 获取公钥
  String? get publicKey => _publicKey;

  // 初始化web3客户端
  void initWeb3Client() {
    if (_web3client == null) {
      print('Initializing web3client...');
      final httpClient = http.Client();
      _web3client =
          Web3Client('https://eth-sepolia.public.blastapi.io', httpClient);
      print('Web3client initialized.');
    }
  }

  // 获取以太坊余额
  Future<double> getBalance() async {
    if (_credentials == null) return 0.0;

    try {
      initWeb3Client();
      final address = await _credentials!.extractAddress();
      final balance = await _web3client!.getBalance(address);
      return balance.getValueInUnit(EtherUnit.ether);
    } catch (e) {
      print('Error getting balance: $e');
      return 0.0;
    }
  }

  // **从助记词生成以太坊私钥**
  Future<bool> generateFromMnemonic(String mnemonic) async {
    try {
      if (!bip39.validateMnemonic(mnemonic)) {
        throw Exception('Invalid mnemonic');
      }

      final seed = bip39.mnemonicToSeed(mnemonic);

      final root = bip32.BIP32.fromSeed(seed);

      final ethNode = root.derivePath("m/44'/60'/0'/0/0");

      _privateKey = HEX.encode(ethNode.privateKey!);

      _credentials = EthPrivateKey.fromHex(_privateKey!);

      _publicKey = _credentials?.address.hex;

      return true;
    } catch (e) {
      print('Error generating wallet: $e');
      return false;
    }
  }

  // 执行合约交易
  Future<TransactionResult> executeContractTransaction({
    required String contractAddress,
    required String functionName,
    required List<dynamic> parameters,
    required BigInt value,
    required String functionAbi,
  }) async {
    if (_credentials == null) {
      return TransactionResult(
        success: false,
        error: 'No wallet credentials found. Please set up your wallet first.',
      );
    }

    try {
      initWeb3Client();

      // 创建合约 ABI
      final contractAbi = ContractAbi.fromJson(
        '[$functionAbi]',
        'DynamicContract',
      );

      final contract = DeployedContract(
        contractAbi,
        EthereumAddress.fromHex(contractAddress),
      );

      final function = contract.function(functionName);
      final address = await _credentials!.extractAddress();
      print(address);
      print(EthereumAddress.fromHex(contractAddress));
      print(EtherAmount.fromBigInt(EtherUnit.wei, value));
      print(function.encodeCall(parameters));
      print("Function name: ${function.name}");
      print("Function parameters: $parameters");

      // 如果是普通转账（没有参数和函数调用）
      if (parameters.isEmpty &&
          (functionName == 'transfer' || functionName.isEmpty)) {
        // print("Executing simple ETH transfer");
        // print("From: $address");
        // print("To: ${EthereumAddress.fromHex(contractAddress)}");
        // print("Value: $value wei");

        // 使用固定的 gas 限制 (21000 是 ETH 转账的标准 gas 限制)
        const gasEstimate = 21000;
        final gasPrice = await _web3client!.getGasPrice();

        // print("Gas limit: $gasEstimate");
        // print("Gas price: $gasPrice");

        final transaction = await _web3client!.sendTransaction(
          _credentials!,
          Transaction(
            to: EthereumAddress.fromHex(contractAddress),
            from: address,
            gasPrice: gasPrice,
            maxGas: gasEstimate,
            value: EtherAmount.inWei(value),
          ),
          chainId: 11155111,
        );

        print("Transaction hash: $transaction");

        // 直接返回交易哈希，不等待确认
        return TransactionResult(
          success: true,
          transactionHash: transaction,
        );
      }

      BigInt gasEstimate = BigInt.from(2000000);
      try {
        // 尝试估算gas
        gasEstimate = await _web3client!.estimateGas(
          sender: address,
          to: EthereumAddress.fromHex(contractAddress),
          data: function.encodeCall(parameters),
          value: EtherAmount.inWei(value),
        );
        print("Estimated gas: $gasEstimate");
      } catch (e) {
        print("Gas estimation failed: $e");
        gasEstimate = BigInt.from(22952); // 降低默认 gas 限制
        print("Using fixed gas limit: $gasEstimate");
      }

      // 获取当前 gas 价格
      final gasPrice = await _web3client!.getGasPrice();
      print("Gas price: $gasPrice");

      // 获取账户余额
      final balance = await _web3client!.getBalance(address);
      print("Account balance: ${balance.getInWei}");

      // 创建并签名交易
      final transaction = await _web3client!.sendTransaction(
        _credentials!,
        Transaction(
          to: EthereumAddress.fromHex(contractAddress),
          from: address,
          gasPrice: gasPrice,
          maxGas: gasEstimate.toInt(),
          value: EtherAmount.inWei(value),
          data: function.encodeCall(parameters),
        ),
        chainId: 11155111, // Sepolia chainId
      );

      print("Transaction hash: $transaction");

      // 直接返回交易哈希，不等待确认
      return TransactionResult(
        success: true,
        transactionHash: transaction,
      );
    } catch (e) {
      return TransactionResult(
        success: false,
        error: e.toString(),
      );
    }
  }

  // 清除数据
  void clear() {
    _credentials = null;
    _privateKey = null;
    _publicKey = null;
  }
}

class TransactionResult {
  final bool success;
  final String? transactionHash;
  final BigInt? gasUsed;
  final BigInt? blockNumber;
  final String? error;

  TransactionResult({
    required this.success,
    this.transactionHash,
    this.gasUsed,
    this.blockNumber,
    this.error,
  });

  String get formattedResult {
    if (!success) {
      return 'Transaction failed. Error: $error';
    }
    return '''Transaction succeeded!
Transaction hash: $transactionHash
Gas used: $gasUsed
Block number: $blockNumber''';
  }
}
