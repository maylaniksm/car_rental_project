import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter card details', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Card Holder',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Expiry Date',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Other Payment Methods', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('assets/images/visa.png',
                    width: 40), // Ganti dengan ikon yang sesuai
                Image.asset('assets/images/mastercard.png',
                    width: 40), // Ganti dengan ikon yang sesuai
                Image.asset('assets/images/paypal.png',
                    width: 40), // Ganti dengan ikon yang sesuai
                Image.asset('assets/images/applepay.png',
                    width: 40), // Ganti dengan ikon yang sesuai
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Checkbox(value: true, onChanged: (bool? value) {}),
                Text("I agree to the terms and conditions"),
              ],
            ),
            Row(
              children: [
                Checkbox(value: true, onChanged: (bool? value) {}),
                Text("Save card details for next time"),
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman SuccessPaymentView
                  Get.toNamed('/success_payment');
                  Get.snackbar("Payment", "Payment confirmed!");
                },
                child: Text('Confirm Payment'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Color(0xFF353392),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
