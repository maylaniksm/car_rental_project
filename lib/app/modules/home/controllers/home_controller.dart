import 'dart:async';

import 'package:car_rental/app/api/vehicle_api.dart';
import 'package:car_rental/app/model/vehicle_model.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class HomeController extends GetxController {
  // Variabel reaktif (jika diperlukan)
  var vehicleList = <String>[].obs; // Misalnya, daftar kendaraan yang tersedia
  var isLoading = false.obs; // Status loading untuk mengambil data kendaraan
  RxList<VehicleModel> listVehicle = <VehicleModel>[].obs;
  late StreamSubscription<RemoteMessage> _foregroundMessageSubscription;
  late StreamSubscription<RemoteMessage> _backgroundMessageSubscription;

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
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _foregroundMessageSubscription.cancel();
    _backgroundMessageSubscription.cancel();
  }

  void getListVehicle()async{
    var res = await VehicleAPI(dio: Dio()).getVehicle();
    if (res.$2) {
      listVehicle.value = res.$1!;
      Logger().e(listVehicle);
    }
  }

  void showToken(){
    FirebaseMessaging.instance.getToken().then((token) {
      Logger().e(token);
    });
  }

   void _setupFCMListeners() {
    _foregroundMessageSubscription = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Get.snackbar("Message", message.notification!.title!);
    });
  }

  void _setupFCMBackgroundListeners() {
    _backgroundMessageSubscription = FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getListVehicle();
    _setupFCMListeners();
    _setupFCMBackgroundListeners();
    showToken();
  }
}
