import 'package:get/get.dart';

class WelcomeController extends GetxController {
  // You can add any variables or methods that will be used in the WelcomeView here.

  // Example variable
  var isLoggedIn = false.obs; // Observable variable

  // Example method to navigate to login
  void navigateToLogin() {
    Get.toNamed('/login');
  }

  // Example method to navigate to register
  void navigateToRegister() {
    Get.toNamed('/register');
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize any data or perform actions when the controller is created.
  }

  @override
  void onReady() {
    super.onReady();
    // Actions to perform when the controller is ready.
  }

  @override
  void onClose() {
    // Cleanup if necessary when the controller is disposed.
    super.onClose();
  }
}
