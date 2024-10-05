import 'package:car_rental/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsController extends GetxController {
  var brand = ''.obs; // Add observable variables
  var price = 0.obs; 
  var imagePath = ''.obs;

  // You can initialize your variables here
  @override
  void onInit() {
    super.onInit();
    // Example data initialization
    brand.value = 'Car Brand';
    price.value = 100; // Example price
    imagePath.value = 'assets/images/car.jpg'; // Example image path
  }
}

void main() {
  Get.put(DetailsController()); // Register the DetailsController here
  runApp(MyApp());
}
