import 'package:get/get.dart';

// Model kendaraan untuk contoh
class Vehicle {
  final String name;
  final String image;
  final String transmission;
  final int seats;
  final int doors;
  final double price;
  final double rating;

  Vehicle({
    required this.name,
    required this.image,
    required this.transmission,
    required this.seats,
    required this.doors,
    required this.price,
    required this.rating,
  });
}

class ResultController extends GetxController {
  var vehicles = <Vehicle>[].obs; // Menyimpan daftar kendaraan
  var selectedIndex = 0.obs; // Indeks untuk BottomNavigationBar
  var withDriver = false.obs; // Status untuk filter "With driver"
  
  // Filter yang dipilih
  var selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    // Contoh data kendaraan, ganti dengan data yang sesuai dari API atau sumber lain
    vehicles.addAll([
      Vehicle(
        name: 'Vehicle 1',
        image: 'assets/images/car1.png',
        transmission: 'Automatic',
        seats: 5,
        doors: 4,
        price: 50,
        rating: 4.5,
      ),
      Vehicle(
        name: 'Vehicle 2',
        image: 'assets/images/car2.png',
        transmission: 'Manual',
        seats: 4,
        doors: 4,
        price: 40,
        rating: 4.0,
      ),
      // Tambahkan kendaraan lainnya sesuai kebutuhan
    ]);
  }

  // Fungsi untuk mengatur filter yang dipilih
  void setFilter(String filter) {
    selectedFilter.value = filter;
    // Logika untuk memperbarui daftar kendaraan berdasarkan filter dapat ditambahkan di sini
  }

  // Fungsi untuk memeriksa apakah filter dipilih
  bool isSelected(String filter) {
    return selectedFilter.value == filter;
  }

  // Fungsi untuk toggle status "With driver"
  void toggleDriver(bool value) {
    withDriver.value = value;
    // Logika untuk memperbarui daftar kendaraan berdasarkan filter dapat ditambahkan di sini
  }

  // Fungsi untuk mengatur indeks BottomNavigationBar
  void onBottomNavTapped(int index) {
    selectedIndex.value = index;
    // Navigasi berdasarkan indeks yang dipilih dapat ditambahkan di sini
  }
}
