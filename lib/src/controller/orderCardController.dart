import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:inpark/src/constants/text_strings.dart';

import '../constants/colors.dart';
import '../model/OrderCardModel.dart';
import '../view/Dashboard/dashboard.dart';
import 'Repositories/user_repository.dart';

class OrderCardController extends GetxController {
  static OrderCardController get instance => Get.find();

  //variables
  final _auth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  // TextField Controllers to get data from textfields
  final vehicleNumberController = TextEditingController();
  final modelController = TextEditingController();
  final companyController = TextEditingController();
  final vehicleTypeController = TextEditingController();
  final phoneNoController = TextEditingController();
  final paymentMethodController = TextEditingController();
  final addressController = TextEditingController();

  Future<void> OrderCard(OrderCardModel order) async {
    await _firebaseFirestore
        .collection("Admin")
        .doc("Cards Order")
        .collection(getCurrentUserUid())
        .doc(order.cardId)
        .set(order.toJason())
        .whenComplete(() {
      Get.snackbar("Success", "Your Order has been confirmed",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PrimaryColor,
          colorText: Colors.black);
      Get.to(Dashboard());
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PrimaryColor,
          colorText: Colors.black);
    });
  }

  Future<String> generateUniqueID() async {
    Random random = Random();
    String id = '';
    bool idExists = true;
    while (idExists) {
      // Generate random four-digit number ID
      id = (random.nextInt(9000) + 1000).toString();
      // Check if ID already exists in Firestore database
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Admin')
          .doc("Cards Order")
          .collection(getCurrentUserUid())
          .where('Card Id', isEqualTo: id)
          .get();
      idExists = snapshot.docs.isNotEmpty;
    }
    return id;
  }

  Future<bool> checkVehicleExists(String vehicleNo) async {
    // Check if vehicle number already exists in Firestore database
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Admin')
        .doc("Cards Order")
        .collection(getCurrentUserUid())
        .where('Vehicle No', isEqualTo: vehicleNo)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  String getCurrentUserUid() {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception("No signed-in user.");
    }
  }

  Future<void> deductCardFee(OrderCardModel order) async {
    double cardOrderingFee = 600;
    final DocumentReference userDoc = FirebaseFirestore.instance
        .collection("Client")
        .doc(getCurrentUserUid())
        .collection("Wallet")
        .doc("Balance");
    final DocumentSnapshot userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      final Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      final double currentBalance = (userData['balance'] ?? 0).toDouble();
      if (currentBalance > 600) {
        final double newBalance = currentBalance - cardOrderingFee;
        await userDoc.update({'balance': newBalance});
        await OrderCard(order);
      } else {
        Get.snackbar("Error", "You don't have enough balance",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: PrimaryColor,
            colorText: Colors.black);
            return;
      }
    } else {
      // User does not exist, create new document with default balance value of 0
      await userDoc.set({'balance': 0});
    }
  }
}
