import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  var selectedBrand = ''.obs; // Stores the selected brand
  var model = ''.obs; // Stores the selected model
  var year = ''.obs; // Stores the selected year
  var modelOptions = <String>[].obs; // Stores the list of models based on selected brand
  var selectedVehicleTypes = <String>[].obs; // Stores selected vehicle types
  var selectedFeatures = <String>[].obs; // Stores selected features
  var priceRange = RangeValues(0, 500).obs; // Default price range

  // A map to define model options based on brand
  final Map<String, List<String>> brandModels = {
    'assets/images/porsche.png': ['Model A', 'Model B'],
    'assets/images/bmw.png': ['Model X', 'Model Y'],
    'assets/images/honda.png': ['Civic', 'Accord'],
    'assets/images/renault.png': ['Clio', 'Captur'],
    'assets/images/mercedes.png': ['A-Class', 'C-Class'],
  };

  void clearFilters() {
    selectedBrand.value = '';
    model.value = '';
    year.value = '';
    modelOptions.clear();
    selectedVehicleTypes.clear();
    selectedFeatures.clear();
    priceRange.value = RangeValues(0, 500);
  }

  void updateModelOptions() {
    // Update model options based on selected brand
    modelOptions.value = brandModels[selectedBrand.value] ?? [];
  }
}
