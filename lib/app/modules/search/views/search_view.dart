import 'package:car_rental/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:car_rental/app/modules/result/views/result_view.dart';
 // Import ResultView

class SearchView extends StatelessWidget {
  final TextEditingController pickUpDateController = TextEditingController();
  final TextEditingController dropOffDateController = TextEditingController();
  final TextEditingController pickUpLocationController = TextEditingController();
  final TextEditingController dropOffLocationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // Kembali ke layar sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Lokasi Pick-up
            Text('Pick-up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: pickUpLocationController,
              decoration: InputDecoration(
                hintText: 'Berlin',
                suffixIcon: GestureDetector(
                  onTap: () async {
                    try {
                      Position position = await _determinePosition();
                      String placeName = await _getPlaceName(position);
                      pickUpLocationController.text = placeName;

                      // Open Google Maps
                      _openMap(position);
                    } catch (e) {
                      print('Error: $e');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/location.png', height: 20),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xFF353392)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Lokasi Drop-off
            Text('Drop-off', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: dropOffLocationController,
              decoration: InputDecoration(
                hintText: 'Paris',
                suffixIcon: GestureDetector(
                  onTap: () async {
                    try {
                      Position position = await _determinePosition();
                      String placeName = await _getPlaceName(position);
                      dropOffLocationController.text = placeName;

                      // Open Google Maps
                      _openMap(position);
                    } catch (e) {
                      print('Error: $e');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/location.png', height: 20),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xFF353392)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Pick-up dan Drop-off Dates
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pick up date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextField(
                        controller: pickUpDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Enter date',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                              child: Image.asset('assets/images/calendar.png', height: 20),
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _selectDate(context, pickUpDateController);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_drop_down, color: Colors.grey),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Color(0xFF353392)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Drop off date', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      TextField(
                        controller: dropOffDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Enter date',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                              child: Image.asset('assets/images/calendar.png', height: 20),
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _selectDate(context, dropOffDateController);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_drop_down, color: Colors.grey),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Color(0xFF353392)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Tombol Pencarian
            Center(
  child: ElevatedButton(
    onPressed: () {
    Get.toNamed(Routes.RESULT);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF353392),
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: Text('Search', style: TextStyle(color: Colors.white)),
  ),
),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF353392), // Ubah warna header
            colorScheme: ColorScheme.light(primary: Color(0xFF353392), secondary: Color(0xFF353392)), // Ubah warna kalender
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      controller.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> _getPlaceName(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    return "${place.locality}, ${place.country}";
  }

  void _openMap(Position position) async {
    final googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
