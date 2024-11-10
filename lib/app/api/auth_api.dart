import 'package:car_rental/app/shared/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthAPI extends DioHandler {
  AuthAPI({required super.dio});

  Future<String?> postAuthUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ("Berhasil Login");
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
        throw (e.message!);
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Logger().w(userCredential);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }
}
