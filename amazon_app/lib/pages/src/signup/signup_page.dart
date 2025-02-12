import 'package:amazon_app/pages/src/start/start_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'parts/progress_indicator.dart';
import 'signup_controller.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SignupScreen();
  }
}

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});
  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final errorMessageProvider = StateProvider<String?>((ref) => null);
  bool isLoading = false;

  Future<void> _signup() async {
    setState(() {
      isLoading = true;
    });

    final errorMessage = await signupController(
      context,
      ref,
      emailController,
      passwordController,
      () => mounted,
    );

    if (errorMessage != null) {
      ref.read(errorMessageProvider.notifier).state = errorMessage;
    } else {
      ref.read(errorMessageProvider.notifier).state = null;
      // 成功した場合の処理をここに書く
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingJudgeProvider);
    final errorMessage = ref.watch(errorMessageProvider);
    return CupertinoPageScaffold(
      backgroundColor: Colors.black,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Color.fromRGBO(116, 85, 255, 0.56),
                Color.fromRGBO(43, 0, 234, 0.18),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 30,
                left: 0,
                width: 40,
                height: 40,
                child: CupertinoButton(
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(
                      context,
                      CupertinoPageRoute<CupertinoPageRoute<dynamic>>(
                        builder: (context) => const StartPage(),
                      ),
                    );
                  },
                ),
              ),
              const SignupProgressIndicator(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Icon
                  Container(
                    margin: const EdgeInsets.all(23),
                    child: const Column(
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.calendar_today,
                          color: Colors.white,
                          size: 103,
                        ),
      
                        //App name
                        Text(
                          'Amazon',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  //エラーメッセージ
                  if (errorMessage != null)
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 20),
                    ),
      
                  Container(
                    width: 346,
                    margin: const EdgeInsets.all(13.5),
                    child: const Text(
                      'メールアドレス登録',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
      
                  //Email form
                  SizedBox(
                    width: 346,
                    height: 46,
                    child: CupertinoTextField(
                      controller: emailController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(9),
                          topRight: Radius.circular(9),
                          bottomLeft: Radius.circular(9),
                          bottomRight: Radius.circular(9),
                        ),
                        color: Colors.transparent,
                        border: Border(
                          left: BorderSide(
                            color: Color.fromRGBO(123, 97, 255, 1),
                          ),
                          top: BorderSide(
                            color: Color.fromRGBO(123, 97, 255, 1),
                          ),
                          right: BorderSide(
                            color: Color.fromRGBO(123, 97, 255, 1),
                          ),
                          bottom: BorderSide(
                            color: Color.fromRGBO(123, 97, 255, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 346,
                    margin: const EdgeInsets.all(13.5),
                    child: const Text(
                      'パスワード',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
      
                  //Password form
                  SizedBox(
                    width: 346,
                    height: 46,
                    child: CupertinoTextField(
                      controller: passwordController,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(9),
                          topRight: Radius.circular(9),
                          bottomLeft: Radius.circular(9),
                          bottomRight: Radius.circular(9),
                        ),
                        color: Colors.transparent,
                        border: Border(
                          left: BorderSide(
                            color: Color.fromRGBO(123, 97, 255, 1),
                          ),
                          top: BorderSide(
                            color: Color.fromRGBO(123, 97, 255, 1),
                          ),
                          right: BorderSide(
                            color: Color.fromRGBO(123, 97, 255, 1),
                          ),
                          bottom: BorderSide(
                            color: Color.fromRGBO(123, 97, 255, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  Container(
                    height: 47,
                    width: 195,
                    margin: const EdgeInsets.all(23),
                    child: CupertinoButton(
                      color: const Color.fromRGBO(80, 49, 238, 0.9),
                      borderRadius: BorderRadius.circular(30),
                      onPressed: isLoading
                          ? null
                          : () async {
                              await _signup();
                            },
                      child: const Text('Sign up'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
