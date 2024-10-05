import 'package:get/get.dart';

class HomeController extends GetxController {
  // Variabel reaktif (jika diperlukan)
  var vehicleList = <String>[].obs; // Misalnya, daftar kendaraan yang tersedia
  var isLoading = false.obs; // Status loading untuk mengambil data kendaraan

  // Fungsi untuk memuat kendaraan
  void fetchVehicles() async {
    isLoading.value = true;
    // Simulasi pengambilan data dari API atau database
    await Future.delayed(Duration(seconds: 2));
    vehicleList.assignAll([
      'Car 1',
      'Car 2',
      'Car 3',
    ]); // Contoh data kendaraan
    isLoading.value = false;
  }

  // Fungsi untuk mencari kendaraan
  void searchVehicles(String query) {
    // Implementasikan logika pencarian kendaraan
    // Misalnya, filter kendaraan dari vehicleList berdasarkan query
  }
}
