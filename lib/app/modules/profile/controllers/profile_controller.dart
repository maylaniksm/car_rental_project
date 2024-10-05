import 'package:get/get.dart';

class ProfileController extends GetxController {
  var username = 'Adrian'.obs;
  var email = 'adrian@example.com'.obs;

  // Function to update profile information
  void updateProfile(String newName, String newEmail) {
    username.value = newName;
    email.value = newEmail;
    // Notify user of successful update
    Get.snackbar('Profile Updated', 'Your profile has been updated successfully.');
  }

  // Function to handle logout
  void logout() {
    // Logic to clear user session can be added here
    Get.offAllNamed('/'); // Redirect to welcome screen
  }
}
