import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:findmyspot/src/controller/signUp_controller.dart';
import 'package:findmyspot/src/model/theftRequestModel.dart';
import 'package:findmyspot/src/view/Dashboard/dashboard.dart';

import '../constants/colors.dart';
import '../model/secondaryVehicleRequestModel.dart';

class requestFormController extends GetxController {
  static requestFormController get instance => Get.find();

  final _firebaseFirestore = FirebaseFirestore.instance;

  // TextField Controllers to get data from Request for secondary vehicle form
  final ownerNameController = TextEditingController();
  final ownerCnicController = TextEditingController();
  final ownerVehicleNumberController = TextEditingController();
  final existingVehicleNumberController = TextEditingController();
  final ownerVehicleTypeController = TextEditingController();
  final parkingManagerEmailController = TextEditingController();

  // TextField Controllers to get data from Theft Request vehicle form
  final nameController = TextEditingController();
  final cnicController = TextEditingController();
  final vehicleNoController = TextEditingController();
  final vehicleTypeController = TextEditingController();
  final theftDateController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<void> requestForSecondaryVehicle(
      secondaryVehicleRequestModel request , var documentID) async {
    final ParkingManagerInstance =
        FirebaseFirestore.instance.collection("Parking Manager");

    ParkingManagerInstance.where("Email",
            isEqualTo: request.parkingManagerEmail)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) async {
      if (querySnapshot.size > 0) {
        // User with matching email found, do further processing here
        await _firebaseFirestore
            .collection("Client")
            .doc(SignUpController().getCurrentUserUid())
            .collection("Request vehicle").doc(documentID)
            .set(request.toJason())
            .whenComplete(() async {
          String userId = querySnapshot.docs[0].id;
          await ParkingManagerInstance.doc(userId)
              .collection("Approve secondary Requests")
              .doc(documentID)
              .set(request.toJason())
              .then((value) => {
                    Get.snackbar("Success",
                        "Your Request for Secondary vehicle has been sent to parking manager",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: PrimaryColor,
                        colorText: Colors.white),
                    Get.to(Dashboard())
                  });
        }).catchError((error, stackTrace) {
          Get.snackbar("Error", "Something went wrong. Try Again",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: PrimaryColor,
              colorText: Colors.black);
        });
      } else {
        // No user with matching email found
        Get.snackbar("Error", "This Parking Manager Email does Not Exist",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: PrimaryColor,
            colorText: Colors.black);
      }
    }).catchError((error) {
      print('Error getting user with email: $error');
    });
  }

  Future<void> theftRequest(theftRequestModel request) async {
    await _firebaseFirestore
        .collection("Vehicle Theft")
        .add(request.toJason())
        .whenComplete(() {
      Get.snackbar(
        "Success",
        "Your Request for vehicle theft has been sent to findmyspot.org. You will get conformation email in 24hrs",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: PrimaryColor,
        colorText: Colors.white,
        duration: Duration(seconds: 10),
      );
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PrimaryColor,
          colorText: Colors.black);
    });
  }
}
