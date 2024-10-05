import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  // Controllers for text fields
  final pickUpController = TextEditingController();
  final dropOffController = TextEditingController();
  final pickUpDateController = TextEditingController();
  final dropOffDateController = TextEditingController();

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
}
