import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:findmyspot/src/controller/signUp_controller.dart';

import '../constants/colors.dart';
import '../model/balanceModel.dart';
import '../model/walletModel.dart';

class walletController extends GetxController {
  static walletController get instance => Get.find();

  //variables
  final _auth = FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> depositMoney(walletModel deposit) async {
    await _firebaseFirestore
        .collection("Client")
        .doc(SignUpController().getCurrentUserUid())
        .collection("Wallet")
        .doc("Transections")
        // .collection(await generateId())
        .collection("Amount Deposit Transection")
        .add(deposit.toJason())
        .whenComplete(() {
      Get.snackbar("Success", "Amount has Been deposit to your account",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PrimaryColor,
          colorText: Colors.black);
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PrimaryColor,
          colorText: Colors.black);
    });
  }
  Future<String> generateId() async {
    String id = '';
    int count = 1;
    bool idExists = true;

    while (idExists) {
      id = 'TID$count';
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Client')
          .doc(SignUpController().getCurrentUserUid())
          .collection('Wallet')
          .doc('Transections')
          .collection(id)
          .get();

      idExists = snapshot.docs.isNotEmpty;
      count++;
    }
    return id;
  }

  Future<void> updateBalance( String depositAmountStr) async {
    final DocumentReference userDoc = FirebaseFirestore.instance
        .collection("Client")
        .doc(SignUpController().getCurrentUserUid())
        .collection("Wallet")
        .doc("Balance");
    final DocumentSnapshot userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      final Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      final double currentBalance = (userData['balance'] ?? 0).toDouble();
      final double depositAmount = double.parse(depositAmountStr);
      final double newBalance = currentBalance + depositAmount;
      await userDoc.update({'balance': newBalance});
    } else {
      // User does not exist, create new document with default balance value of 0
      await userDoc.set({'balance': 0});
      final double depositAmount = double.parse(depositAmountStr);
      await userDoc.update({'balance': depositAmount});
    }
  }

  Future<String> getBalance() async {
    final DocumentReference userDoc = FirebaseFirestore.instance.collection("Client")
        .doc(SignUpController().getCurrentUserUid())
        .collection("Wallet")
        .doc("Balance");
    final DocumentSnapshot userSnapshot = await userDoc.get();
    if (userSnapshot.exists) {
      final Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
      final double balance = (userData['balance'] ?? 0).toDouble();
      return '${balance.toStringAsFixed(1)}';
    } else {
      return 'User does not exist';
    }
  }
  Future<List<walletModel>> getTransections() async {
    final snapshot = await _firebaseFirestore
        .collection('Client')
        .doc(SignUpController().getCurrentUserUid())
        .collection('Wallet')
        .doc('Transections')
        .collection("Amount Deposit Transection").get();
    final userdata =
    snapshot.docs.map((e) => walletModel.fromSnapshot(e)).toList();
    return userdata;
  }

}
