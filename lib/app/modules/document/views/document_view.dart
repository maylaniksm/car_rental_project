import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/document_controller.dart';
import 'dart:io';

class DocumentView extends GetView<DocumentController> {
  const DocumentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Documents'),
        backgroundColor: Color(0xFF353392),
      ),
      body: Obx(() => controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  _buildProfileInfo(
                      'Email', controller.user.value.email, Icons.email),
                  _buildProfileInfo(
                      'Phone', controller.user.value.phoneNumber, Icons.phone),
                  _buildDriversLicenseInfo(),
                  _buildProfileInfo(
                      'License Expiry',
                      controller
                          .formatDate(controller.user.value.licenseExpiryDate),
                      Icons.date_range),
                  _buildProfileInfo('KTP Number',
                      controller.user.value.ktpNumber, Icons.credit_card),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _showAddDocumentDialog(),
                      child: Text('Add Document'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF353392),
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Rental History',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF353392),
                    ),
                  ),
                  SizedBox(height: 10),
                  ...controller.user.value.rentalHistory
                      .asMap()
                      .entries
                      .map((entry) =>
                          _buildRentalHistoryItem(entry.value, entry.key))
                      .toList(),
                  SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: _showDeleteOptions,
                      child: Text('Delete Rental History'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRentalDialog(),
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF353392),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildProfileInfo(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF353392)),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Color(0xFF353392)),
            onPressed: () => _showEditDocumentDialog(label),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => _showDeleteDocumentConfirmation(label),
          ),
        ],
      ),
    );
  }

  Widget _buildDriversLicenseInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(Icons.card_membership, color: Color(0xFF353392)),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Driver\'s License',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                if (controller.user.value.driversLicenseUrl.isNotEmpty)
                  Image.network(
                    controller.user.value.driversLicenseUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                else
                  Text('No image uploaded'),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Color(0xFF353392)),
            onPressed: () => _showEditDriversLicenseDialog(),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () =>
                _showDeleteDocumentConfirmation('Driver\'s License'),
          ),
        ],
      ),
    );
  }

  Widget _buildRentalHistoryItem(RentalHistory rental, int index) {
    return Obx(() => Card(
          margin: EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: rental.isSelected.value,
                  onChanged: (_) => controller.toggleRentalSelection(index),
                ),
                Icon(Icons.car_rental, color: Color(0xFF353392)),
              ],
            ),
            title: Text(rental.vehicleName),
            subtitle: Text(
                '${rental.plateNumber}\n${controller.formatDate(rental.startDate)} - ${controller.formatDate(rental.endDate)}'),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Color(0xFF353392)),
                  onPressed: () => _showEditRentalDialog(rental, index),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _showDeleteRentalConfirmation(index),
                ),
              ],
            ),
            onTap: () => _showRentalDetailsDialog(rental),
          ),
        ));
  }

  void _showAddDocumentDialog() {
    final labelController = TextEditingController();
    final valueController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: Text('Add Document'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: labelController,
              decoration: InputDecoration(labelText: 'Label'),
            ),
            TextField(
              controller: valueController,
              decoration: InputDecoration(labelText: 'Value'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () async {
              if (labelController.text.isNotEmpty &&
                  valueController.text.isNotEmpty) {
                if (labelController.text == 'Driver\'s License') {
                  _showEditDriversLicenseDialog();
                } else {
                  controller.addDocument(
                      labelController.text, valueController.text);
                  Get.back();
                  Get.snackbar('Success', 'Document added successfully');
                }
              } else {
                Get.snackbar('Error', 'Please fill in all fields');
              }
            },
          ),
        ],
      ),
    );
  }

  void _showEditDocumentDialog(String label) {
    final valueController =
        TextEditingController(text: controller.getDocumentValue(label));

    Get.dialog(
      AlertDialog(
        title: Text('Edit $label'),
        content: TextField(
          controller: valueController,
          decoration: InputDecoration(labelText: 'Value'),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () {
              if (valueController.text.isNotEmpty) {
                controller.updateDocument(label, valueController.text);
                Get.back();
                Get.snackbar('Success', '$label updated successfully');
              } else {
                Get.snackbar('Error', 'Please fill in the value');
              }
            },
          ),
        ],
      ),
    );
  }

  void _showEditDriversLicenseDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Update Driver\'s License'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Get.back();
                File? image = await controller.pickImage();
                if (image != null) {
                  controller.addDocument('Driver\'s License', image);
                  Get.snackbar(
                      'Success', 'Driver\'s License updated successfully');
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Photo'),
              onTap: () async {
                Get.back();
                File? image = await controller.takePhoto();
                if (image != null) {
                  controller.addDocument('Driver\'s License', image);
                  Get.snackbar(
                      'Success', 'Driver\'s License updated successfully');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDocumentConfirmation(String label) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete $label'),
        content: Text(
            'Are you sure you want to delete this document? This action cannot be undone.'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              controller.deleteDocument(label);
              Get.back();
              Get.snackbar('Success', '$label deleted successfully');
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteOptions() {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.delete_outline),
              title: Text('Delete Selected'),
              onTap: () {
                Get.back();
                if (controller.hasSelectedRentals) {
                  _showDeleteConfirmation(deleteSelected: true);
                } else {
                  Get.snackbar('No Selection', 'Please select items to delete');
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text('Delete All'),
              onTap: () {
                Get.back();
                _showDeleteConfirmation(deleteSelected: false);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation({required bool deleteSelected}) {
    Get.dialog(
      AlertDialog(
        title: Text(
            deleteSelected ? 'Delete Selected Rentals' : 'Delete All Rentals'),
        content: Text(
            'Are you sure you want to delete ${deleteSelected ? 'the selected' : 'all'} rental history? This action cannot be undone.'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              if (deleteSelected) {
                controller.deleteSelectedRentalHistory();
              } else {
                controller.deleteAllRentalHistory();
              }
              Get.back();
              Get.snackbar('Rental History Deleted',
                  '${deleteSelected ? 'Selected' : 'All'} rental history has been successfully deleted.');
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddRentalDialog() {
    final vehicleNameController = TextEditingController();
    final plateNumberController = TextEditingController();
    final startDateController = TextEditingController();
    final endDateController = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: Text('Add Rental History'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: vehicleNameController,
                decoration: InputDecoration(labelText: 'Vehicle Name'),
              ),
              TextField(
                controller: plateNumberController,
                decoration: InputDecoration(labelText: 'Plate Number'),
              ),
              TextField(
                controller: startDateController,
                decoration: InputDecoration(labelText: 'Start Date'),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    startDateController.text = controller.formatDate(date);
                  }
                },
              ),
              TextField(
                controller: endDateController,
                decoration: InputDecoration(labelText: 'End Date'),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    endDateController.text = controller.formatDate(date);
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Add'),
            onPressed: () {
              if (vehicleNameController.text.isNotEmpty &&
                  plateNumberController.text.isNotEmpty &&
                  startDateController.text.isNotEmpty &&
                  endDateController.text.isNotEmpty) {
                final newRental = RentalHistory(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  vehicleName: vehicleNameController.text,
                  plateNumber: plateNumberController.text,
                  startDate: controller.parseDate(startDateController.text),
                  endDate: controller.parseDate(endDateController.text),
                );
                controller.addRentalHistory(newRental);
                Get.back();
                Get.snackbar('Success', 'Rental history added successfully');
              } else {
                Get.snackbar('Error', 'Please fill in all fields');
              }
            },
          ),
        ],
      ),
    );
  }

  void _showEditRentalDialog(RentalHistory rental, int index) {
    final vehicleNameController =
        TextEditingController(text: rental.vehicleName);
    final plateNumberController =
        TextEditingController(text: rental.plateNumber);
    final startDateController =
        TextEditingController(text: controller.formatDate(rental.startDate));
    final endDateController =
        TextEditingController(text: controller.formatDate(rental.endDate));

    Get.dialog(
      AlertDialog(
        title: Text('Edit Rental History'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: vehicleNameController,
                decoration: InputDecoration(labelText: 'Vehicle Name'),
              ),
              TextField(
                controller: plateNumberController,
                decoration: InputDecoration(labelText: 'Plate Number'),
              ),
              TextField(
                controller: startDateController,
                decoration: InputDecoration(labelText: 'Start Date'),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: Get.context!,
                    initialDate: rental.startDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    startDateController.text = controller.formatDate(date);
                  }
                },
              ),
              TextField(
                controller: endDateController,
                decoration: InputDecoration(labelText: 'End Date'),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: Get.context!,
                    initialDate: rental.endDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    endDateController.text = controller.formatDate(date);
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Save'),
            onPressed: () {
              if (vehicleNameController.text.isNotEmpty &&
                  plateNumberController.text.isNotEmpty &&
                  startDateController.text.isNotEmpty &&
                  endDateController.text.isNotEmpty) {
                final updatedRental = RentalHistory(
                  id: rental.id,
                  vehicleName: vehicleNameController.text,
                  plateNumber: plateNumberController.text,
                  startDate: controller.parseDate(startDateController.text),
                  endDate: controller.parseDate(endDateController.text),
                );
                controller.updateRentalHistory(index, updatedRental);
                Get.back();
                Get.snackbar('Success', 'Rental history updated successfully');
              } else {
                Get.snackbar('Error', 'Please fill in all fields');
              }
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteRentalConfirmation(int index) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Rental History'),
        content: Text(
            'Are you sure you want to delete this rental history? This action cannot be undone.'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              controller.deleteRentalHistory(index);
              Get.back();
              Get.snackbar('Success', 'Rental history deleted successfully');
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _showRentalDetailsDialog(RentalHistory rental) {
    Get.dialog(
      AlertDialog(
        title: Text('Rental Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailItem('Vehicle Name', rental.vehicleName),
            _buildDetailItem('Plate Number', rental.plateNumber),
            _buildDetailItem(
                'Start Date', controller.formatDate(rental.startDate)),
            _buildDetailItem('End Date', controller.formatDate(rental.endDate)),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
