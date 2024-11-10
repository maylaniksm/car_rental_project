import 'package:car_rental/app/modules/webview/controllers/webview_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebviewPageController>(() => WebviewPageController());
  }
}