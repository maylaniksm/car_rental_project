import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
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
        title: Text('Top Result', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16),
                    SizedBox(width: 8),
                    Text('11. Nov 12:00 - 14.Nov 13:00', style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16),
                    SizedBox(width: 8),
                    Text('Berlin-Paris', style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All', true),
                      SizedBox(width: 8),
                      _buildFilterChip('Budget Friendly', false),
                      SizedBox(width: 8),
                      _buildFilterChip('Most Popular', false),
                      SizedBox(width: 8),
                      _buildFilterChip('Offer', false),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('96 vehicles available', style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text('With driver'),
                        Switch(
                          value: true,
                          onChanged: (value) {},
                          activeColor: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildCarCard('assets/images/ddd.png', 'S 500 Sedan', 'A/T', 5, 4, 4.1, 50),
                _buildCarCard('assets/images/iris.png', 'Audi', 'A/T', 5, 4, 4.1, 50),
                _buildCarCard('assets/images/audi.png', 'Audi A4', 'A/T', 5, 4, 4.3, 55),
                _buildCarCard('assets/images/hyundai.png', 'Hyundai Sonata', 'A/T', 5, 4, 4.0, 45),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF353392),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: [
          BottomNavigationBarItem(icon: Image.asset('assets/images/home.png', color: Colors.white, height: 24), label: ''),
          BottomNavigationBarItem(icon: Image.asset('assets/images/calendar.png', color: Colors.white, height: 24), label: ''),
          BottomNavigationBarItem(icon: Image.asset('assets/images/search.png', color: Colors.white, height: 24), label: ''),
          BottomNavigationBarItem(icon: Image.asset('assets/images/ikonprofil.png', color: Colors.white, height: 24), label: ''),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF353392) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFF353392)),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Color(0xFF353392)),
      ),
    );
  }

  Widget _buildCarCard(String imagePath, String model, String transmission, int seats, int doors, double rating, int price) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(imagePath, width: 100, height: 60, fit: BoxFit.cover),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.settings, size: 16),
                      SizedBox(width: 4),
                      Text(transmission),
                      SizedBox(width: 8),
                      Icon(Icons.airline_seat_recline_normal, size: 16),
                      SizedBox(width: 4),
                      Text('$seats'),
                      SizedBox(width: 8),
                      Icon(Icons.door_front_door, size: 16),
                      SizedBox(width: 4),
                      Text('$doors'),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text('Free cancellation', style: TextStyle(color: Colors.green)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    SizedBox(width: 4),
                    Text('$rating'),
                  ],
                ),
                SizedBox(height: 4),
                Text('$price\$/Day', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}