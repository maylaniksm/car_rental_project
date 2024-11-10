import 'package:car_rental/app/api/auth_api.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  void navigateToRegister() {
    Get.toNamed('/register');
  }

  void userRegister({required String email, required String password})async {
    try {
      await AuthAPI(dio: Dio()).register(email: email, password: password);
      Get.snackbar("Success", "Berhasil Register");
      Get.toNamed('/login');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
