import 'package:gebelik_aapp/features/auth/domain/entities/user_model.dart';

abstract class AuthRepo {
  Future<void> signin(String email, String password);
  Future<void> signup(String email, String password);
  Future<void> saveUserFirestore(String email, String name, String surname, int age, String haftalik, DateTime dogumTarihi);
  Future<UserModel?> getCurrentUser();
}