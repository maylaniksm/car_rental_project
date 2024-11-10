import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/webview_controller.dart';

class WebviewView extends GetView<WebviewPageController> {
  const WebviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(WebviewPageController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('WebviewPageView'),
          centerTitle: true,
        ),
        body: WebViewWidget(
          controller: controller
              .webViewControllers("https://adamputratravel.com/sewa-mobil/"),
        ));
  }
}
