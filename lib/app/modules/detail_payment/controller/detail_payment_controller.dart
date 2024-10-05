import 'package:car_rental/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPaymentcontroller extends GetxController {
  var brand = ''.obs; // Add observable variables
  var price = 0.obs; 
  var imagePath = ''.obs;

  // You can initialize your variables here
  @override
  void onInit() {
    super.onInit();
    
  }
}

void main() {
  Get.put(DetailPaymentcontroller()); // Register the DetailsController here
  runApp(MyApp());
}
