import 'package:flutter/material.dart';
import 'package:gebelik_aapp/features/auth/presentation/pages/sign_in_page.dart';
import 'package:gebelik_aapp/features/auth/presentation/pages/sign_up_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  void toggleButton() {
    setState(() {
      isLogin = !isLogin;
    });
  }
  @override
  Widget build(BuildContext context) {
    return isLogin ? const SignInPage() : const SignUpPage();
  }
}
