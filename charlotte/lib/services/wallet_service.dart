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
      final httpClient = http.Client();
      _web3client =
          Web3Client('https://ethereum-sepolia.publicnode.com', httpClient);
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

  // 清除数据
  void clear() {
    _credentials = null;
    _privateKey = null;
    _publicKey = null;
  }
}
