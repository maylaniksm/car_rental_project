import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DateController extends GetxController {
  final pickUpLocationController = TextEditingController();
  final dropOffLocationController = TextEditingController();
  final pickUpDateController = TextEditingController();
  final dropOffDateController = TextEditingController();

  // Firebase Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Firebase Authentication instance to get the current user
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Get the current user ID dynamically from FirebaseAuth
  String get userId =>
      auth.currentUser?.uid ?? 'guest'; // Default to 'guest' if not logged in

  // Pick up date picker
  Future<void> pickUpDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      pickUpDateController.text = picked.toString().substring(0, 10);
    }
  }

  // Drop off date picker
  Future<void> dropOffDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      dropOffDateController.text = picked.toString().substring(0, 10);
    }
  }

  // Function to save booking to Firestore
  Future<void> saveBooking() async {
    // Validate input
    if (pickUpLocationController.text.isEmpty ||
        dropOffLocationController.text.isEmpty ||
        pickUpDateController.text.isEmpty ||
        dropOffDateController.text.isEmpty) {
      Get.snackbar("Error", "All fields must be filled out");
      return;
    }

    try {
      // Save booking data to rentalHistory collection in user document
      await firestore
          .collection('users')
          .doc(userId)
          .collection('bookings')
          .add({
        'pickUp': pickUpLocationController.text,
        'dropOff': dropOffLocationController.text,
        'pickUpDate': pickUpDateController.text,
        'dropOffDate': dropOffDateController.text,
        'timestamp':
            FieldValue.serverTimestamp(), // Add a timestamp for tracking
      });
      Get.snackbar("Success", "Booking saved successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to save booking: ${e.toString()}");
    }
  }

  // Select date method
  void selectPickUpDate(BuildContext context) {
    _selectDate(context, pickUpDateController);
  }

  void selectDropOffDate(BuildContext context) {
    _selectDate(context, dropOffDateController);
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF353392), // Modify header color
            colorScheme: ColorScheme.light(
              primary: Color(0xFF353392),
              secondary: Color(0xFF353392),
            ), // Modify calendar colors
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      controller.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }
}
