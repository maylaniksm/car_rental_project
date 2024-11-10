import 'package:car_rental/app/modules/detail_payment/screen.dart';
import 'package:car_rental/app/modules/webview/views/webview_page_view.dart';
import 'package:get/get.dart';
import '../modules/register/views/register_view.dart';
import '../modules/welcome/controllers/welcome_controller.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/welcome/views/welcome_view.dart';
import '../modules/search/views/search_view.dart';
import '../modules/result/views/result_view.dart';
import '../modules/result/bindings/result_binding.dart';
import '../modules/details/views/details_view.dart';
import '../modules/details/bindings/details_binding.dart';
import '../modules/webview/bindings/webview_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: Routes.WELCOME,
      page: () => WelcomeView(),
      binding: BindingsBuilder(() {
        Get.put(WelcomeController());
      }),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => SearchView(),
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: Routes.RESULT,
      page: () => ResultView(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: Routes.DETAILS,
      page: () => DetailsView(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: Routes.DETAILPAYMENT,
      page: () => DetailPaymentScreen(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: Routes.WEBVIEW,
      page: () => WebviewView(),
      binding: WebViewBinding(), // Binding untuk WebviewPageController
    ),
  ];
}
