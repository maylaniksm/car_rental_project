import 'package:car_rental/app/model/vehicle_model.dart';
import 'package:car_rental/app/shared/dio.dart';
import 'package:logger/logger.dart';

class VehicleAPI extends DioHandler{
  VehicleAPI({required super.dio});
  

  Future<(List<VehicleModel>?,bool)> getVehicle() async {
    try {
      var res = await getData(url: 'https://auto.dev/api/listings?apikey=ZrQEPSkKaXNtYWlsc2w0ODdAZ21haWwuY29t');
      if (res != null) {
        var data = res['records'] as List;
        var vehicle = data.map((e) => VehicleModel.fromJson(e)).toList();
        return (vehicle,true);
      } else {
        return (null,false);
      }
    } catch (e) {
      return (null,false);
    }
  }
}