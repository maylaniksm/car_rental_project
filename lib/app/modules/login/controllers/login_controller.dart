import 'package:car_rental/app/api/auth_api.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // Function to handle user login
  void login() {
    // Perform login logic here
    if (email.value.isNotEmpty && password.value.isNotEmpty) {
      // Assume successful login, navigate to home
      Get.toNamed('/home');
    } else {
      // Show error message
      Get.snackbar('Error', 'Please fill in all fields');
    }
  }

  void loginAuthController(
      {required String email, required String pass}) async {
    try {
      await AuthAPI(dio: Dio()).postAuthUser(
        email: email,
        password: pass,
      );
      Get.offAllNamed('/home');
      Get.snackbar("Success", "Berhasil Login");
    }catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
