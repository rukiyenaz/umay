import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebelik_aapp/features/auth/domain/repositories/auth_repo.dart';
import 'package:gebelik_aapp/features/auth/presentation/cubits/state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  Future<void> signin(String email, String password) async {
    emit(AuthLoading());
    try {
      await authRepo.signin(email, password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signup(String email, String password) async {
    emit(AuthLoading());
    try {
      await authRepo.signup(email, password);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> saveUserFirestore(String email, String name, String surname, int age, String haftalik, DateTime dogumTarihi) async {
    emit(AuthLoading());
    try {
      await authRepo.saveUserFirestore(email, name, surname, age, haftalik, dogumTarihi);
      emit(Authenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());
    try {
      final user = await authRepo.getCurrentUser();
      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}