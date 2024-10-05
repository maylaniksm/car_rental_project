import 'package:car_rental/app/modules/detail_payment/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:car_rental/app/modules/details/controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
          controller.brand.value,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
  height: 200,
  child: PageView(
    children: [
      Obx(() => controller.imagePath.value.isNotEmpty 
          ? Image.asset(controller.imagePath.value, fit: BoxFit.cover) 
          : Placeholder()), // Fallback to Placeholder if imagePath is empty
    ],
  ),
),

            SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) =>
                  Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 0 ? Colors.blue : Colors.grey,
                    ),
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Specification',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSpecItem(Icons.local_gas_station, 'Diesel'),
                      _buildSpecItem(Icons.ac_unit, 'Cool Seat'),
                      _buildSpecItem(Icons.speed, 'Acceleration'),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Obx(() => Text(
                        controller.brand.value,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                      Spacer(),
                      Obx(() => Text(
                        '${controller.price.value} \$',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                      )),
                      Text(
                        '/per day',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: 4.9,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      SizedBox(width: 5),
                      Text('4.9', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(' (230 Reviews)', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildFeatureRow(Icons.airline_seat_recline_normal, '5 Seats', Icons.door_front_door, '4 Doors'),
                  _buildFeatureRow(Icons.settings, 'Manual', Icons.ac_unit, 'Air Conditioning'),
                  SizedBox(height: 20),
                  Text(
                    'What\'s included?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Mileage'),
                  Text('3000 km balance', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 10),
                  Text('Tax and Insurance'),
                  Text('Our prices include mandatory taxes such as VAT,\nVehicle licensing Fee.', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 20),
                  Text(
                    'Price',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Obx(() => Text(
                    '${controller.price.value} \$/Day',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                  )),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(DetailPaymentScreen());
                      },
                      child: Text('Rent Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF353392),
                        padding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildFeatureRow(IconData icon1, String label1, IconData icon2, String label2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon1, size: 20, color: Colors.grey),
          SizedBox(width: 5),
          Text(label1),
          SizedBox(width: 20),
          Icon(icon2, size: 20, color: Colors.grey),
          SizedBox(width: 5),
          Text(label2),
        ],
      ),
    );
  }
}
