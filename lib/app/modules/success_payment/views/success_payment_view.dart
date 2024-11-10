import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/success_payment_controller.dart';

class SuccessPaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SuccessPaymentController controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Judul halaman
              Text(
                'Successful Payment',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40), // Memberi jarak antara judul dan GIF

              // Menambahkan animasi GIF
              Container(
                width: 180, // Ukuran kotak untuk GIF yang lebih besar
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50], // Warna latar belakang kotak
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/suc.gif', // Path ke GIF
                    fit: BoxFit.cover, // Mengatur ukuran agar sesuai
                  ),
                ),
              ),
              SizedBox(
                  height:
                      40), // Memberi jarak antara GIF dan teks "Successful!"

              // Pesan keberhasilan
              Text(
                'Successful!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10), // Jarak tambahan di bawah "Successful!"

              Text(
                'Successfully made payment',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                  height:
                      60), // Memberi jarak yang cukup sebelum tombol Booking Details

              // Tombol Booking Details
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Arahkan ke halaman detail pemesanan
                    Get.toNamed('/dashboard');
                  },
                  child: Text('Booking Details'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Color(0xFF353392), // Warna tombol
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Arahkan ke halaman utama
                  Get.toNamed('/home');
                },
                child: Text(
                  'Back to home',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
