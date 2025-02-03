import 'package:flutter/material.dart';
import '../services/wallet_service.dart';
import 'chat_screen.dart';

class MnemonicScreen extends StatefulWidget {
  const MnemonicScreen({super.key});

  @override
  State<MnemonicScreen> createState() => _MnemonicScreenState();
}

class _MnemonicScreenState extends State<MnemonicScreen> {
  final List<TextEditingController> _controllers = List.generate(
    12,
    (index) => TextEditingController(),
  );

  // 处理批量粘贴
  void _handlePaste(String value) {
    // 移除多余的空格并按空格分割
    final words = value.trim().split(RegExp(r'\s+'));

    // 填充到输入框
    for (var i = 0; i < words.length && i < 12; i++) {
      _controllers[i].text = words[i];
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8B7EF8), Color(0xFF9F94FF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 返回按钮
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // 标题
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          child: const Column(
                            children: [
                              Text(
                                'Enter Your Mnemonic',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Please enter your 12-word recovery phrase',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 80),
                        // 助记词输入区域
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 2.5,
                                ),
                                itemCount: 12,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: TextField(
                                      controller: _controllers[index],
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '${index + 1}',
                                        hintStyle: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                      // 添加文本输入限制
                                      textInputAction: index == 11
                                          ? TextInputAction.done
                                          : TextInputAction.next,
                                      onSubmitted: (value) {
                                        if (index < 11) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      // 为第一个输入框添加粘贴处理
                                      onChanged: index == 0
                                          ? (value) {
                                              if (value.contains(' ')) {
                                                _handlePaste(value);
                                                // 清空第一个输入框的空格
                                                _controllers[0].text = value
                                                    .trim()
                                                    .split(RegExp(r'\s+'))[0];
                                              }
                                            }
                                          : null,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    // 获取所有助记词
                                    final words = _controllers
                                        .map((controller) =>
                                            controller.text.trim())
                                        .where((word) => word.isNotEmpty)
                                        .toList();

                                    // 检查是否填写了所有助记词
                                    if (words.length != 12) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Please enter all 12 words'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    // 转换为助记词字符串
                                    final mnemonic = words.join(' ');

                                    // 生成私钥
                                    final success = await WalletService()
                                        .generateFromMnemonic(mnemonic);

                                    if (!success) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Invalid mnemonic phrase'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    // 导航到聊天界面
                                    Navigator.pushReplacement(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ChatScreen(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2D2B52),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Continue',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
