import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/auth/presentation/cubits/cubit.dart';
import 'package:http/http.dart' as context;

class UserInfo extends StatelessWidget {
  UserInfo({super.key});

  
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController haftalikController = TextEditingController();
  TextEditingController dogumTarihiController = TextEditingController();

  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('User Info Page'),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: surnameController,
              decoration: const InputDecoration(
                labelText: 'Surname',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: haftalikController,
              decoration: const InputDecoration(
                labelText: 'Haftalık',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: dogumTarihiController,
              decoration: const InputDecoration(
                labelText: 'Doğum Tarihi',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(onPressed: () async {
              await context.read<AuthCubit>().saveUserFirestore(
                "${user.email}",
                nameController.text,
                surnameController.text,
                int.tryParse(ageController.text) ?? 0,
                haftalikController.text,
                DateTime.tryParse(dogumTarihiController.text) ?? DateTime.now(),
              );
            }, child: const Text('Kaydet')),
          ],
        ),
      ),
    );
  }
}