import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gebelik_aapp/features/auth/domain/entities/user_model.dart';
import 'package:gebelik_aapp/features/auth/domain/repositories/auth_repo.dart';

class FirebaseAuthService implements AuthRepo {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  User? get user => auth.currentUser;


  @override
  Future<UserModel?> getCurrentUser() async{
    if (user != null){
      DocumentSnapshot userDoc = 
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      if (userDoc.exists) {
        return Future.value(UserModel(
          id: user!.uid,
          email: userDoc['email'],
          name: userDoc['name'],
          surname: userDoc['surname'],
          age: userDoc['age'],
          haftalik: userDoc['haftalik'],
          dogumTarihi: (userDoc['dogumTarihi'] as Timestamp).toDate(),
        ));
      }
    }
    return Future.value(null);
  }

  @override
  Future<void> saveUserFirestore(String email, String name, String surname, int age, String haftalik, DateTime dogumTarihi) async{
    try {
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': name,
        'email': email,
        'surname': surname,
        'age': age,
        'haftalik': haftalik,
        'dogumTarihi': dogumTarihi,
      });
    } catch (e) {
      Exception('Kullanıcı verileri kaydedilemedi: $e');
    }
  }

  @override
  Future<void> signin(String email, String password) async{
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Exception('Giriş başarısız: $e');
      // Handle error
    }
  }

  @override
  Future<void> signup(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // Handle error
      Exception('Kayıt başarısız: $e');
    }
  }

}