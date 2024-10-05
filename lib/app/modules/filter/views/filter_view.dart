import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental/app/modules/filter/controllers/filter_controller.dart';

class FilterView extends StatelessWidget {
  final FilterController controller = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter by'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(); // Kembali ke halaman sebelumnya
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.clearFilters();
            },
            child: Text('Clear All', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Brand', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildBrandSelection(),
            SizedBox(height: 20),
            Text('Model and Year', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildModelAndYearDropdowns(),
            SizedBox(height: 20),
            _buildVehicleTypeSelection(),
            SizedBox(height: 20),
            _buildPriceRangeSlider(),
            SizedBox(height: 10),
            _buildSetPriceRangeButton(),
            SizedBox(height: 20),
            _buildOtherFeatures(),
            Spacer(),
            _buildShowResultButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandSelection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...[ 
            'assets/images/porsche.png',
            'assets/images/bmw.png',
            'assets/images/honda.png',
            'assets/images/renault.png',
            'assets/images/mercedes.png'
          ].map((imagePath) {
            return GestureDetector(
              onTap: () {
                controller.selectedBrand.value = imagePath;
                controller.updateModelOptions(); // Update model options based on selected brand
              },
              child: Obx(() {
                bool isSelected = controller.selectedBrand.value == imagePath;
                return _buildBrandIcon(imagePath, isSelected);
              }),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBrandIcon(String imagePath, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
      ),
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.only(right: 15),
      child: Image.asset(imagePath, height: 60),
    );
  }

  Widget _buildModelAndYearDropdowns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildDropdown(
            'Model',
            controller.model.value,
            (value) {
              controller.model.value = value!;
            },
            // Populate model options with sample data
            RxList<String>(['Option 1', 'Option 2', 'Option 3']),
          ),
        ),
        SizedBox(width: 10),
        Expanded(child: _buildYearDropdown()),
      ],
    );
  }

  Widget _buildDropdown(String label, String selectedValue, Function(String?) onChanged, RxList<String> options) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey), // Same border style
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedValue.isNotEmpty ? selectedValue : null,
        hint: Text(label),
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        underline: SizedBox(),
      ),
    );
  }

  Widget _buildYearDropdown() {
    List<String> years = List.generate(25, (index) => (DateTime.now().year - index).toString());

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey), // Ensure the border matches the dropdown style
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButton<String>(
        isExpanded: true,
        value: controller.year.value.isNotEmpty ? controller.year.value : null,
        hint: Text('Year'),
        items: years.map<DropdownMenuItem<String>>((String year) {
          return DropdownMenuItem<String>(
            value: year,
            child: Text(year),
          );
        }).toList(),
        onChanged: (String? value) {
          controller.year.value = value!;
        },
        underline: SizedBox(),
      ),
    );
  }

  Widget _buildVehicleTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vehicle Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildVehicleTypeOption('Sedan'),
            _buildVehicleTypeOption('SUV'),
            _buildVehicleTypeOption('Crossover'),
            _buildVehicleTypeOption('Hatchback'),
          ],
        ),
      ],
    );
  }

  Widget _buildVehicleTypeOption(String type) {
    return Obx(() {
      bool isSelected = controller.selectedVehicleTypes.contains(type);
      return ChoiceChip(
        label: Text(type),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            controller.selectedVehicleTypes.add(type);
          } else {
            controller.selectedVehicleTypes.remove(type);
          }
        },
        selectedColor: Color(0xFF353392),
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      );
    });
  }

  Widget _buildPriceRangeSlider() {
    // Set initial price range to 0
    controller.priceRange.value = RangeValues(0, 0); // Ensure initial range is 0

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Price Range', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RangeSlider(
                values: controller.priceRange.value,
                min: 0,
                max: controller.priceRange.value.end, // Make the maximum flexible
                divisions: 100, // Adjust divisions for finer control
                labels: RangeLabels(
                  '\$${controller.priceRange.value.start.toInt()}',
                  '\$${controller.priceRange.value.end.toInt()}',
                ),
                onChanged: (RangeValues values) {
                  controller.priceRange.value = values;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${controller.priceRange.value.start.toInt()}'),
                  Text('\$${controller.priceRange.value.end.toInt()}'),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildSetPriceRangeButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showSetPriceRangeDialog();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text('Set Price Range', style: TextStyle(color: Colors.black)),
      ),
    );
  }

  void _showSetPriceRangeDialog() {
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  // Initialize the controllers with the current price range
  minController.text = controller.priceRange.value.start.toString();
  maxController.text = controller.priceRange.value.end.toString();

  Get.dialog(
    AlertDialog(
      title: Text('Set Price Range'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: minController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Minimum Price'),
          ),
          TextField(
            controller: maxController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Maximum Price'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            double minPrice = double.tryParse(minController.text) ?? 0;
            double maxPrice = double.tryParse(maxController.text) ?? double.infinity; // Allow max price to be unlimited

            // Clamp the minimum price to be at least 0
            if (minPrice < 0) minPrice = 0;

            // Ensure min is not greater than max
            if (minPrice > maxPrice) {
              double temp = minPrice;
              minPrice = maxPrice;
              maxPrice = temp;
            }

            // Update the price range in the controller
            controller.priceRange.value = RangeValues(minPrice, maxPrice);
            Get.back();
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}

  Widget _buildOtherFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Other Features', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // For even spacing
          children: [
            _buildFeatureOption('GPS'),
            _buildFeatureOption('Sunroof'),
            _buildFeatureOption('Manual'),    // Added Manual option
            _buildFeatureOption('Automatic'),  // Added Automatic option
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureOption(String feature) {
    return Obx(() {
      bool isSelected = controller.selectedFeatures.contains(feature);
      return ChoiceChip(
        label: Text(feature),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            controller.selectedFeatures.add(feature);
          } else {
            controller.selectedFeatures.remove(feature);
          }
        },
        selectedColor: Color(0xFF353392),
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
        padding: EdgeInsets.symmetric(horizontal: 8), // Adjust padding for tighter appearance
        shape: RoundedRectangleBorder(
          side: BorderSide(color: isSelected ? Colors.blue : Colors.grey), // Border color based on selection
          borderRadius: BorderRadius.circular(12),
        ),
      );
    });
  }

  Widget _buildShowResultButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Handle show results action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF353392),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        ),
        child: Text('Show Results', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
