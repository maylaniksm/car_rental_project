import 'package:car_rental/app/modules/details/controllers/details_controller.dart';
import 'package:car_rental/app/modules/details/views/details_view.dart';
import 'package:car_rental/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Adjust the path as necessary


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Sample vehicle data
  final List<Vehicle> vehicles = [
    Vehicle(name: 'BMW', imagePath: 'assets/images/bmw.png'),
    Vehicle(name: 'Toyota', imagePath: 'assets/images/toyota.png'),
    Vehicle(name: 'Mercedes', imagePath: 'assets/images/mercedes.png'),
    Vehicle(name: 'Audi', imagePath: 'assets/images/audi.png'),
    Vehicle(name: 'Porsche', imagePath: 'assets/images/porsche.png'),
    Vehicle(name: 'Maserati', imagePath: 'assets/images/maserati.png'),
  ];

  final List<String> brands = ['Mercedes', 'BMW', 'Maserati', 'Porsche', 'Toyota'];
  final List<String> recommended = ['BMW', 'Toyota', 'Audi', 'Honda'];

  List<Vehicle> filteredVehicles = [];
  List<String> filteredBrands = [];
  List<String> filteredRecommended = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    Get.put(HomeController());
    filteredVehicles = vehicles;
    filteredBrands = brands;
    filteredRecommended = recommended;

  }

  void _searchVehicles(String query) {
    
    setState(() {
      searchQuery = query;
      filteredVehicles = query.isEmpty
          ? vehicles
          : vehicles
              .where((vehicle) => vehicle.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
      filteredBrands = query.isEmpty
          ? brands
          : brands.where((brand) => brand.toLowerCase().contains(query.toLowerCase())).toList();
      filteredRecommended = query.isEmpty
          ? recommended
          : recommended.where((rec) => rec.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Get.toNamed('/profile');
              },
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/profile');
              },
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profil.png'),
                radius: 20,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              'Maylani',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 10),

            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search a vehicle',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        _searchVehicles(value);
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/filter');
                    },
                    child: Image.asset(
                      'assets/images/filter.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Displaying Search Results
            if (searchQuery.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Search Results for "$searchQuery":', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  ...filteredVehicles.map((vehicle) {
                    return ListTile(
                      leading: Image.asset(vehicle.imagePath, width: 40, height: 40, fit: BoxFit.cover),
                      title: Text(vehicle.name),
                      onTap: () {
                        // Handle vehicle tap if needed
                      },
                    );
                  }).toList(),
                  SizedBox(height: 20),
                  Text('Brands:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  ...filteredBrands.map((brand) {
                    return ListTile(
                      title: Text(brand),
                      onTap: () {
                        // Handle brand tap if needed
                      },
                    );
                  }).toList(),
                  SizedBox(height: 20),
                  Text('Recommended:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  ...filteredRecommended.map((rec) {
                    return ListTile(
                      title: Text(rec),
                      onTap: () {
                        // Handle recommended item tap if needed
                      },
                    );
                  }).toList(),
                ],
              ),
            SizedBox(height: 20),

            // Carousel Slider
            Container(
              height: 200,
              child: PageView(
                children: [
                  _buildPromoCard('assets/images/iris.png', 'Enjoy our Nov Deals', '30% off'),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Our Brands with See All button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Our Brands', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    // Navigate to 'See All'
                  },
                  child: Text(
                    'See All >',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBrandCard('assets/images/mercedes.png', 'Mercedes', '+32'),
                _buildBrandCard('assets/images/bmw.png', 'BMW', '+12'),
                _buildBrandCard('assets/images/maserati.png', 'Maserati', '+5'),
                _buildBrandCard('assets/images/porsche.png', 'Porsche', '+8'),
              ],
            ),
            SizedBox(height: 20),

            // Recommended with See All button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recommended', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      // Navigate to 'See All'
                    },
                    child: Text(
                      'See All >',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Obx(() => 
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                 ...controller.listVehicle.map((element) => _buildRecommendedCard(element.primaryPhotoUrl, "${element.make} ${element.model}", 65),)
                  
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF353392),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/home.png', height: 24),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/calendar.png', height: 24),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/search.png', height: 24),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/ikonprofil.png', height: 24),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Get.toNamed('/home');
              break;
            case 1:
              Get.toNamed('/calendar');
              break;
            case 2:
              Get.toNamed('/search');
              break;
            case 3:
              Get.toNamed('/profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildPromoCard(String imagePath, String title, String subtitle) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandCard(String imagePath, String brandName, String count) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 5),
        Text(brandName),
        Text(count, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildRecommendedCard(String imagePath, String brand, int price) {
  return GestureDetector(
    onTap: () {
      // Get.lazyPut(() => DetailsController());
      Get.to(DetailsView(), arguments: {
      'brand': 'Toyota',
      'image': 'assets/toyota.png',
      'price': 100,
    });
  },
   
 
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Starting Price',
                    style: TextStyle(fontSize: 12, color: Colors.blue),
                  ),
                  Text(
                    '\$$price/Day',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Vehicle {
  final String name;
  final String imagePath;

  Vehicle({required this.name, required this.imagePath});
}
