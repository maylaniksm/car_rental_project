import 'package:get/get.dart';
import '../controllers/success_payment_controller.dart';

class SuccessPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SuccessPaymentController>(() => SuccessPaymentController());
  }
}
