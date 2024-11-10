import 'package:car_rental/app/modules/webview/controllers/webview_controller.dart';
import 'package:car_rental/app/modules/webview/views/webview_page_view.dart';
import 'package:car_rental/app/routes/app_pages.dart';
import 'package:car_rental/app/shared/fcm.dart';
import 'package:car_rental/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/booking/controllers/booking_controller.dart';
import 'app/modules/date/controllers/date_controller.dart';
import 'app/modules/date/views/date_view.dart';
import 'app/modules/document/views/document_view.dart';
import 'app/modules/document/controllers/document_controller.dart';
import 'app/modules/payment/controllers/payment_controller.dart';
import 'app/modules/register/views/register_view.dart';
import 'app/modules/success_payment/controllers/success_payment_controller.dart';
import 'app/modules/success_payment/views/success_payment_view.dart';
import 'app/modules/welcome/views/welcome_view.dart'; // Import WelcomeView
import 'app/modules/login/views/login_view.dart'; // Import LoginView
import 'app/modules/home/views/home_view.dart'; // Import HomeView
import 'app/modules/profile/views/profile_view.dart'; // Import ProfileView
import 'app/modules/filter/views/filter_view.dart'; // Import FilterView
import 'app/modules/search/views/search_view.dart'; // Import SearchView
import 'app/modules/dashboard/views/dashboard_view.dart'; // Import DashboardView
import 'app/modules/result/views/result_view.dart'; // Import ResultView
import 'app/modules/details/views/details_view.dart'; // Import ResultView
import 'app/modules/payment/views/payment_view.dart'; // Import PaymentView
import 'app/modules/booking/views/booking_view.dart'; // Import BookingView

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FCMHandler().initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Car Rental App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Set the initial route to the WelcomeView
      getPages: [
        GetPage(name: '/', page: () => WelcomeView()),
        GetPage(
            name: '/register',
            page: () => RegisterView(),
            binding: BindingsBuilder(() {
              Get.lazyPut(() => AuthController());
            })), // Route to Welcome View
        GetPage(
            name: '/login',
            page: () => LoginView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<AuthController>(() => AuthController());
            })), // Route to Login View
        GetPage(name: '/home', page: () => HomeView()), // Route to Home View
        GetPage(
            name: '/profile',
            page: () => ProfileView()), // Route to Profile View
        GetPage(
            name: '/filter', page: () => FilterView()), // Route to Filter View
        GetPage(
            name: '/search', page: () => SearchView()), // Route to Search View
        GetPage(name: '/dashboard', page: () => DashboardView()),
        GetPage(
            name: '/date',
            page: () => DateView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<DateController>(() => DateController());
            })),
        GetPage(
            name: '/success_payment',
            page: () => SuccessPaymentView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<SuccessPaymentController>(
                  () => SuccessPaymentController());
            })),
        GetPage(
            name: '/payment',
            page: () => PaymentView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<PaymentController>(() => PaymentController());
            })),
        GetPage(
            name: '/booking',
            page: () => BookingView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<BookingController>(() => BookingController());
            })),
        GetPage(
            name: '/document',
            page: () => DocumentView(),
            binding: BindingsBuilder(() {
              Get.lazyPut<DocumentController>(() => DocumentController());
            })),
        GetPage(name: '/result', page: () => ResultView()),
        GetPage(
            name: '/details',
            page: () => DetailsView()), // Route to Result View
        GetPage(
          name: Routes.WEBVIEW,
          page: () => WebviewView(),
          binding: BindingsBuilder(() {
            Get.lazyPut<WebviewPageController>(() => WebviewPageController());
          }),
        ),
      ],
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}
