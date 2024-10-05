import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Add controller logic here if needed
}

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Dashboard',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBookingTabs(),
              SizedBox(height: 16),
              _buildOngoingBooking(),
              SizedBox(height: 16),
              _buildReportAccidentCard(),
              SizedBox(height: 16),
              _buildFreeWeekendSwapCard(),
              SizedBox(height: 16),
              _buildExploreButton(),
              SizedBox(height: 16),
              _buildUpcomingPayment(),
              SizedBox(height: 16),
              _buildOngoingRequest(),
              SizedBox(height: 16),
              _buildMyDocuments(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingTabs() {
    return Row(
      children: [
        _buildTab('Ongoing Booking', true),
        SizedBox(width: 16),
        _buildTab('Previous Booking', false),
      ],
    );
  }

  Widget _buildTab(String title, bool isActive) {
    return Text(
      title,
      style: TextStyle(
        color: isActive ? Colors.green : Colors.grey,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildOngoingBooking() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your Booking : SM12911234', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Image.asset('assets/images/hyundai.png', height: 60),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hyundai - 2021'),
                          Text('📅 29/11/2023 - 01/03/2024', style: TextStyle(color: Colors.grey)),
                          _buildStatusChip('Payment Status: completed'),
                          Text('Remaining time: 1 m 12 d', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mileage - 4500km'),
                Text('Insurance: 3000 km balance'),
                Text('Extras: Standard'),
                Text('Additional Driver'),
                Text('Child Seats - 2'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'View more booking details',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.green, fontSize: 12),
      ),
    );
  }

  Widget _buildReportAccidentCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/danger.png', height: 24),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Report an Accident / Breakdown',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildFreeWeekendSwapCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE6E6FA),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Image.asset('assets/images/swap.png', height: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Free Weekend Swap',
                  style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
                ),
                Text(
                  'You are now eligible for a free weekend swap.',
                  style: TextStyle(color: Colors.indigo.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.indigo),
        ],
      ),
    );
  }

  Widget _buildExploreButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Explore our November Collection!'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF353392),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildUpcomingPayment() {
    return _buildSection(
      title: 'Upcoming payment',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('380 \$', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text('Due on 12/12/2023', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text('view payment history', style: TextStyle(color: Colors.blue)),
          SizedBox(height: 8),
          Text('View breakdown', style: TextStyle(color: Colors.blue)),
          SizedBox(height: 8),
          _buildWarningCard('Your selected card has expired. Please update your payment method to ensure timely payments.'),
        ],
      ),
    );
  }

  Widget _buildOngoingRequest() {
    return _buildSection(
      title: 'Ongoing Request',
      content: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildOngoingRequestCard(
              title: 'Repair Service',
              date: 'Requested on 12/12/2023',
              status: 'Under Process',
            ),
            SizedBox(width: 16),
            _buildOngoingRequestCard(
              title: 'Car Wash',
              date: 'Requested on 15/12/2023',
              status: 'Pending',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOngoingRequestCard({
    required String title,
    required String date,
    required String status,
  }) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(date, style: TextStyle(color: Colors.grey, fontSize: 12)),
          SizedBox(height: 8),
          _buildStatusChip(status),
          SizedBox(height: 8),
          Text('Request for a service', style: TextStyle(color: Colors.blue, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMyDocuments() {
    return _buildSection(
      title: 'My Documents',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWarningCard('Your Emirates ID has expired. Please upload your latest Emirates ID.'),
          SizedBox(height: 8),
          _buildSuccessCard('Your Driver\'s License has been verified'),
          SizedBox(height: 8),
          Text('view all documents', style: TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget content}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget _buildWarningCard(String text) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFFF0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

  Widget _buildSuccessCard(String text) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: Colors.green))),
        ],
      ),
    );
  }
}