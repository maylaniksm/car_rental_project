import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Importing the image picker
import 'dart:io'; // For File class

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _profileImage; // Variable to hold the profile image
  final ImagePicker _picker =
      ImagePicker(); // Create an instance of ImagePicker
  String _name = 'Garin'; // Default name
  TextEditingController _nameController = TextEditingController();

  Future<void> _pickImage() async {
    // Show a dialog to choose between camera and gallery
    final choice = await showDialog<ImageSource>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose Image Source'),
          actions: [
            TextButton(
              child: Text('Camera'),
              onPressed: () => Navigator.pop(context, ImageSource.camera),
            ),
            TextButton(
              child: Text('Gallery'),
              onPressed: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        );
      },
    );

    if (choice != null) {
      final XFile? pickedFile =
          await _picker.pickImage(source: choice); // Use the chosen source
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path); // Update the profile image
        });
      }
    }
  }

  void _editName() {
    // Show a dialog to edit the name
    _nameController.text = _name; // Pre-fill the text field
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Name'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: "Enter your name"),
          ),
          actions: [
            TextButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _name = _nameController.text; // Update name
                });
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(), // Close dialog
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF353392), // Navy color for AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the home page
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        color: Color(0xFF353392), // Navy background color
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Name at the top right corner
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Rental Car',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),

            // Profile Section with Image and Name
            Row(
              children: [
                GestureDetector(
                  onTap: _pickImage, // Open image picker on tap
                  child: CircleAvatar(
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!) // Use selected image
                        : AssetImage('assets/images/profil.png')
                            as ImageProvider, // Default image
                    radius: 40, // Slightly larger profile image
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name, // Display the name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Image.asset(
                    'assets/images/edit.png', // Custom edit icon
                    height: 20,
                    color: Colors.white,
                  ),
                  onPressed: _editName, // Edit profile logic here
                ),
              ],
            ),
            SizedBox(height: 30),

            // Menu Items
            _buildMenuItem('My Dashboard', Icons.dashboard_outlined, () {
              Navigator.of(context)
                  .pushNamed('/dashboard'); // Navigate to DashboardView
            }),
            _buildMenuItem('Notification', Icons.notifications_outlined),
            _buildMenuItem('My Documents', Icons.file_copy_outlined, () {
              Navigator.of(context)
                  .pushNamed('/document'); // Navigate to MyDocumentsView
            }),
            _buildMenuItem('About Us', Icons.info_outline, () {
              Get.toNamed('/webview'); // Menggunakan Get untuk navigasi
            }),

            _buildMenuItem('Setting', Icons.settings_outlined),

            Spacer(),

            // Logout Button
            Center(
              child: ElevatedButton(
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/welcome', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Button background color
                  foregroundColor: Color(0xFF353392), // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded button
                    side: BorderSide(color: Color(0xFF353392)), // Navy border
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF353392), // Text color
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Menu Item Widget
  Widget _buildMenuItem(String title, IconData icon, [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap, // Call the passed function on tap
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: 16.0), // Padding for spacing
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon,
                    color: Colors.white,
                    size: 20), // Adjusted icon size for consistency
                SizedBox(width: 15),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18, // Slightly larger font for menu items
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16), // Arrow icon size for consistency
          ],
        ),
      ),
    );
  }
}
