import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AuthService {
  Future<void> register({
    required String email,
    required String password,
  }) async {
    Logger().e(":dasasdjaslkdsa");
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Logger().w(userCredential);
    } on FirebaseAuthException catch (e) {
      Logger().e(e.message);
      if (e.code == 'weak-password') {
        throw e.toString();
        // Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // Get.snackbar('Error', 'The account already exists for that email.');
        throw e.toString();
      } else {
        throw e.toString();
      }
    }
  }
}

Future<void> login({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    Logger().e(userCredential);
  } on FirebaseAuthException catch (e) {
    Logger().e(e);
    if (e.code == 'user-not-found') {
      Get.snackbar('Error', 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      Get.snackbar('Error', 'Wrong password provided for that user.');
    }
  }
}

Future<void> logout({
  required BuildContext context,
}) async {
  await FirebaseAuth.instance.signOut();
}
