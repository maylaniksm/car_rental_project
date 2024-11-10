import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PaymentController extends GetxController {
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  var agreeTerms = false.obs;
  var saveCard = false.obs;

  void toggleAgreeTerms() {
    agreeTerms.value = !agreeTerms.value;
  }

  void toggleSaveCard() {
    saveCard.value = !saveCard.value;
  }

  @override
  void onClose() {
    cardHolderController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.onClose();
  }
}
