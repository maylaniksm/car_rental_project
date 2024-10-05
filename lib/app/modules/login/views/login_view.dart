import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign in',
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
                decoration: InputDecoration(
                  labelText: 'Email address',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 16),

              // Password Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Menyembunyikan input password
              ),

              // Lupa Password
              TextButton(
                onPressed: () {
                  // Aksi ketika tombol lupa password ditekan
                },
                child: Text('Forget Password?'),
              ),

              SizedBox(height: 16),

              // Tombol Sign In
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman Home setelah login berhasil
                  Get.toNamed('/home'); // Arahkan ke halaman Home
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF353392), // Warna tombol
                  minimumSize: Size(double.infinity, 50), // Lebar penuh
                ),
                child: Text(
                  'sign in',
                  style: TextStyle(
                    color: Colors.white, // Warna teks putih
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Opsi untuk login dengan sosial media
              Center(child: Text('or continue with')),

              // Ikon Sosial Media
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('assets/images/fb.png', width: 40),
                  Image.asset('assets/images/google.png', width: 40),
                  Image.asset('assets/images/apple.png', width: 40),
                ],
              ),

              // Tautan untuk pendaftaran
              Center(
                child: TextButton(
                  onPressed: () {
                    // Aksi ketika tautan "Create an account" ditekan
                  },
                  child: Text(
                    'Not registered? Create an account',
                    style: TextStyle(
                      color: Colors.blue, // Warna tautan
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
