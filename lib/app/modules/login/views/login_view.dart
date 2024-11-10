import 'package:car_rental/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_rental/app/modules/auth/controllers/auth_controller.dart';
import '../../register/views/register_view.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loginController = Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Please enter your login credentials below',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 32),

              // Email Field
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email address',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 16),

              // Password Field
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),

              // Forgot Password
              TextButton(
                onPressed: () {
                  // Action when forgot password button is pressed
                  // You can implement password reset functionality here
                },
                child: Text('Forget Password?'),
              ),

              SizedBox(height: 16),

              // Sign In Button
              ElevatedButton(
                onPressed: () async {
                  loginController.loginAuthController(
                      email: _emailController.text,
                      pass: _passwordController.text);
                  // try {
                  //   await authController.login(
                  //     email: _emailController.text,
                  //     password: _passwordController.text,
                  //     context: context,
                  //   );
                  //   // Navigate to Home page after successful login
                  //   Get.offAllNamed('/home');
                  // } catch (e) {
                  //   Get.snackbar('Error', e.toString(),
                  //       snackPosition: SnackPosition.BOTTOM);
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF353392),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'sign in',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Social media login options
              Center(child: Text('or continue with')),

              // Social Media Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/fb.png', width: 40),
                  Image.asset('assets/images/google.png', width: 40),
                  Image.asset('assets/images/apple.png', width: 40),
                ],
              ),

              // Registration link
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.to(() => RegisterView());
                  },
                  child: Text(
                    'Not registered? Create an account',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthController {
  login(
      {required String email,
      required String password,
      required BuildContext context}) {}

  register(
      {required String email,
      required String password,
      required String name}) {}
}
