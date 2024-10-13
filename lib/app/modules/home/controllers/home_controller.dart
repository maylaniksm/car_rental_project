import 'package:car_rental/app/api/vehicle_api.dart';
import 'package:car_rental/app/model/vehicle_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomeController extends GetxController {
  // Variabel reaktif (jika diperlukan)
  var vehicleList = <String>[].obs; // Misalnya, daftar kendaraan yang tersedia
  var isLoading = false.obs; // Status loading untuk mengambil data kendaraan
  RxList<VehicleModel> listVehicle = <VehicleModel>[].obs;

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

  void getListVehicle()async{
    var res = await VehicleAPI(dio: Dio()).getVehicle();
    if (res.$2) {
      listVehicle.value = res.$1!;
      Logger().e(listVehicle);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListVehicle();
  }
}
