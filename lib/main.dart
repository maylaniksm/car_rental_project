import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/modules/welcome/views/welcome_view.dart'; // Import WelcomeView
import 'app/modules/login/views/login_view.dart'; // Import LoginView
import 'app/modules/home/views/home_view.dart'; // Import HomeView
import 'app/modules/profile/views/profile_view.dart'; // Import ProfileView
import 'app/modules/filter/views/filter_view.dart'; // Import FilterView
import 'app/modules/search/views/search_view.dart'; // Import SearchView
import 'app/modules/dashboard/views/dashboard_view.dart'; // Import DashboardView
import 'app/modules/result/views/result_view.dart'; // Import ResultView
import 'app/modules/details/views/details_view.dart'; // Import ResultView

void main() {
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
        GetPage(name: '/', page: () => WelcomeView()), // Route to Welcome View
        GetPage(name: '/login', page: () => LoginView()), // Route to Login View
        GetPage(name: '/home', page: () => HomeView()), // Route to Home View
        GetPage(name: '/profile', page: () => ProfileView()), // Route to Profile View
        GetPage(name: '/filter', page: () => FilterView()), // Route to Filter View
        GetPage(name: '/search', page: () => SearchView()), // Route to Search View
        GetPage(name: '/dashboard', page: () => DashboardView()), // Route to Dashboard View
        GetPage(name: '/result', page: () => ResultView()),
        GetPage(name: '/details', page: () => DetailsView()), // Route to Result View
      ],
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}


