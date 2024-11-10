import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class RentalHistory {
  String id;
  String vehicleName;
  String plateNumber;
  DateTime startDate;
  DateTime endDate;
  RxBool isSelected = false.obs;

  RentalHistory({
    required this.id,
    required this.vehicleName,
    required this.plateNumber,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'vehicleName': vehicleName,
      'plateNumber': plateNumber,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  static RentalHistory fromMap(Map<String, dynamic> map, String id) {
    return RentalHistory(
      id: id,
      vehicleName: map['vehicleName'] ?? '',
      plateNumber: map['plateNumber'] ?? '',
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
    );
  }
}

class RentalUser {
  String email;
  String phoneNumber;
  String driversLicenseUrl;
  DateTime licenseExpiryDate;
  String ktpNumber;
  List<RentalHistory> rentalHistory;

  RentalUser({
    required this.email,
    required this.phoneNumber,
    required this.driversLicenseUrl,
    required this.licenseExpiryDate,
    required this.ktpNumber,
    required this.rentalHistory,
  });

  String get id => 'user123'; // Replace with actual user ID getter
}

class DocumentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String userId = 'user123'; // Replace with actual user ID

  final Rx<RentalUser> user = RentalUser(
    email: 'Garin@gnail.com',
    phoneNumber: '',
    driversLicenseUrl: '',
    licenseExpiryDate: DateTime.now(),
    ktpNumber: '',
    rentalHistory: [],
  ).obs;

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    isLoading.value = true;
    error.value = '';
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        user.value = RentalUser(
          email: userData['email'] ?? '',
          phoneNumber: userData['phoneNumber'] ?? '',
          driversLicenseUrl: userData['driversLicenseUrl'] ?? '',
          licenseExpiryDate:
              (userData['licenseExpiryDate'] as Timestamp).toDate(),
          ktpNumber: userData['ktpNumber'] ?? '',
          rentalHistory: [],
        );

        // Fetch rental history
        QuerySnapshot rentalDocs = await _firestore
            .collection('users')
            .doc(userId)
            .collection('rentalHistory')
            .get();

        user.value.rentalHistory = rentalDocs.docs
            .map((doc) => RentalHistory.fromMap(
                doc.data() as Map<String, dynamic>, doc.id))
            .toList();
      }
    } catch (e) {
      error.value = 'Error fetching user data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addDocument(String label, dynamic value) async {
    isLoading.value = true;
    error.value = '';
    try {
      if (label == 'Driver\'s License') {
        if (value is File) {
          print('Uploading Driver\'s License image');
          String imageUrl = await _uploadImage(value);
          print('Image uploaded, updating Firestore');
          await _firestore
              .collection('users')
              .doc(userId)
              .update({'driversLicenseUrl': imageUrl});
          user.update((val) {
            if (val != null) {
              val.driversLicenseUrl = imageUrl;
            }
          });
          print('Firestore updated successfully');
        } else {
          throw Exception('Invalid file for Driver\'s License');
        }
      } else {
        await _firestore.collection('users').doc(userId).update({label: value});
        user.update((val) {
          if (val != null) {
            switch (label) {
              case 'Email':
                val.email = value;
                break;
              case 'Phone':
                val.phoneNumber = value;
                break;
              case 'License Expiry':
                val.licenseExpiryDate = parseDate(value);
                break;
              case 'KTP Number':
                val.ktpNumber = value;
                break;
            }
          }
        });
      }
      user.refresh();
    } catch (e) {
      print('Error in addDocument: $e');
      if (e is FirebaseException) {
        print('Firebase error code: ${e.code}');
        print('Firebase error message: ${e.message}');
      }
      error.value = 'Error adding document: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<String> _uploadImage(File image) async {
    try {
      String fileName =
          'drivers_license_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = _storage.ref().child('drivers_licenses/$fileName');
      print('Attempting to upload image: $fileName');

      UploadTask uploadTask = storageRef.putFile(image);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print(
            'Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes} bytes');
      }, onError: (e) {
        print('Upload error: $e');
      });

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print('Image uploaded successfully. URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print('Error in _uploadImage: $e');
      if (e is FirebaseException) {
        print('Firebase error code: ${e.code}');
        print('Firebase error message: ${e.message}');
      }
      throw e;
    }
  }

  Future<void> updateDocument(String label, dynamic value) async {
    isLoading.value = true;
    error.value = '';
    try {
      if (label == 'Driver\'s License') {
        if (value is File) {
          String imageUrl = await _uploadImage(value);
          await _firestore
              .collection('users')
              .doc(userId)
              .update({'driversLicenseUrl': imageUrl});
          user.update((val) {
            if (val != null) {
              val.driversLicenseUrl = imageUrl;
            }
          });
        } else {
          throw Exception('Invalid file for Driver\'s License');
        }
      } else {
        await _firestore.collection('users').doc(userId).update({label: value});
        user.update((val) {
          if (val != null) {
            switch (label) {
              case 'Email':
                val.email = value;
                break;
              case 'Phone':
                val.phoneNumber = value;
                break;
              case 'License Expiry':
                val.licenseExpiryDate = parseDate(value);
                break;
              case 'KTP Number':
                val.ktpNumber = value;
                break;
            }
          }
        });
      }
    } catch (e) {
      error.value = 'Error updating document: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDocument(String label) async {
    isLoading.value = true;
    error.value = '';
    try {
      if (label == 'Driver\'s License') {
        await _firestore
            .collection('users')
            .doc(userId)
            .update({'driversLicenseUrl': FieldValue.delete()});
        // Optionally, delete the image from Firebase Storage
        if (user.value.driversLicenseUrl.isNotEmpty) {
          await FirebaseStorage.instance
              .refFromURL(user.value.driversLicenseUrl)
              .delete();
        }
        user.update((val) {
          if (val != null) {
            val.driversLicenseUrl = '';
          }
        });
      } else {
        await _firestore
            .collection('users')
            .doc(userId)
            .update({label: FieldValue.delete()});
        user.update((val) {
          if (val != null) {
            switch (label) {
              case 'Email':
                val.email = '';
                break;
              case 'Phone':
                val.phoneNumber = '';
                break;
              case 'License Expiry':
                val.licenseExpiryDate = DateTime.now();
                break;
              case 'KTP Number':
                val.ktpNumber = '';
                break;
            }
          }
        });
      }
    } catch (e) {
      error.value = 'Error deleting document: $e';
    } finally {
      isLoading.value = false;
    }
  }

  String getDocumentValue(String label) {
    switch (label) {
      case 'Email':
        return user.value.email;
      case 'Phone':
        return user.value.phoneNumber;
      case 'Driver\'s License':
        return user.value.driversLicenseUrl;
      case 'License Expiry':
        return formatDate(user.value.licenseExpiryDate);
      case 'KTP Number':
        return user.value.ktpNumber;
      default:
        return '';
    }
  }

  Future<void> addRentalHistory(RentalHistory rental) async {
    isLoading.value = true;
    error.value = '';
    try {
      DocumentReference docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('rentalHistory')
          .add(rental.toMap());

      rental.id = docRef.id;
      user.update((val) {
        val?.rentalHistory.add(rental);
      });
    } catch (e) {
      error.value = 'Error adding rental history: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateRentalHistory(
      int index, RentalHistory updatedRental) async {
    isLoading.value = true;
    error.value = '';
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('rentalHistory')
          .doc(updatedRental.id)
          .update(updatedRental.toMap());

      user.update((val) {
        if (val != null && index >= 0 && index < val.rentalHistory.length) {
          val.rentalHistory[index] = updatedRental;
        }
      });
    } catch (e) {
      error.value = 'Error updating rental history: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteRentalHistory(int index) async {
    isLoading.value = true;
    error.value = '';
    try {
      String rentalId = user.value.rentalHistory[index].id;
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('rentalHistory')
          .doc(rentalId)
          .delete();

      user.update((val) {
        val?.rentalHistory.removeAt(index);
      });
    } catch (e) {
      error.value = 'Error deleting rental history: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAllRentalHistory() async {
    isLoading.value = true;
    error.value = '';
    try {
      WriteBatch batch = _firestore.batch();
      QuerySnapshot rentalDocs = await _firestore
          .collection('users')
          .doc(userId)
          .collection('rentalHistory')
          .get();

      for (var doc in rentalDocs.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      user.update((val) {
        val?.rentalHistory = [];
      });
    } catch (e) {
      error.value = 'Error deleting all rental history: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSelectedRentalHistory() async {
    isLoading.value = true;
    error.value = '';
    try {
      WriteBatch batch = _firestore.batch();
      List<RentalHistory> toDelete = user.value.rentalHistory
          .where((rental) => rental.isSelected.value)
          .toList();

      for (var rental in toDelete) {
        batch.delete(_firestore
            .collection('users')
            .doc(userId)
            .collection('rentalHistory')
            .doc(rental.id));
      }

      await batch.commit();
      user.update((val) {
        val?.rentalHistory.removeWhere((rental) => rental.isSelected.value);
      });
    } catch (e) {
      error.value = 'Error deleting selected rental history: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleRentalSelection(int index) {
    user.value.rentalHistory[index].isSelected.toggle();
  }

  bool get hasSelectedRentals =>
      user.value.rentalHistory.any((rental) => rental.isSelected.value);

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  DateTime parseDate(String date) {
    return DateFormat('dd MMM yyyy').parse(date);
  }

  Future<File?> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }

  Future<File?> takePhoto() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      return File(photo.path);
    }
    return null;
  }
}
