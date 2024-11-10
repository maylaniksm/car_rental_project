import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPageController extends GetxController {
  WebViewController? _controller;

  WebViewController webViewControllers(String url) {
    _controller = WebViewController()..loadRequest(Uri.parse(url));
    return _controller!;
  }

  @override
  void onClose() {
    _controller = null; // Bersihkan controller saat tidak dipakai
    super.onClose();
  }
}
