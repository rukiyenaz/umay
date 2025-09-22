import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/auth/presentation/cubits/cubit.dart';

class SignInPage extends StatelessWidget {
  final VoidCallback toggleButton;
  SignInPage({super.key, required this.toggleButton});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign In Page'),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () async {
              await context.read<AuthCubit>().signin(emailController.text, passwordController.text);
            }, child: const Text('Sign In')),
            ElevatedButton(
              onPressed: () {
                toggleButton();
              },
              child: const Text('Go to Sign Up'),
            ),
          ],
        )
      ),
    );
  }
}