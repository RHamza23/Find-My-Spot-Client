import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:inpark/src/controller/signUp_controller.dart';

import '../constants/colors.dart';
import '../model/AddVehicleModel.dart';
import '../model/OrderCardModel.dart';
import '../model/cardInformationModel.dart';
import '../model/parkingDetailModel.dart';

class  AddVehicleController extends GetxController{

  static AddVehicleController get instance =>  Get.find();
  //variables
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;


  // TextField Controllers to get data from textfields
  final vehiclNoController = TextEditingController();
  final fullnameController = TextEditingController();
  final cardIdController = TextEditingController();

  //call the function from design and it will do the rest


  Future<void> adddCard(String vehicleNo, String name, String cardId) async {
    final CollectionReference vehicleCardsRef =
    FirebaseFirestore.instance.collection('Admin').doc("Cards Order").collection(SignUpController().getCurrentUserUid().toString());
    final DocumentSnapshot cardSnapshot =
    await vehicleCardsRef.doc(cardId).get();

    if (cardSnapshot.exists) {
      final Map<String, dynamic>? data = cardSnapshot.data() as Map<String, dynamic>?;

      if (data?['Vehicle No'] == vehicleNo && data?['Name'] == name) {
        final DocumentReference cardsRef =
        FirebaseFirestore.instance.collection('Client').doc(SignUpController().getCurrentUserUid().toString()).collection("cards").doc(cardId);

        await cardsRef.set(data!).whenComplete(() => {
        Get.snackbar("Success", "Your Card has been successfully added to your account",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: PrimaryColor,
        colorText: Colors.black),

        }); // use ! to assert that data is not null
      } else {
        Get.snackbar("Error", "Vehicle Number & Name is wrong",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: PrimaryColor,
            colorText: Colors.black);
      }
    } else {
      Get.snackbar("Error", "Wrong Card Id",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: PrimaryColor,
          colorText: Colors.black);
    }
  }

  Future<List<OrderCardModel>> getCardsDetails() async {
    final snapshot = await  FirebaseFirestore.instance.
        collection('Client')
        .doc(SignUpController().getCurrentUserUid())
        .collection('cards')
        .get();
    final userdata =
    snapshot.docs.map((e) => OrderCardModel.fromSnapshot(e)).toList();
    return userdata;
  }

  Future<List<parkingDetailModel>> getCardsParkingDetails(String cardId) async {
    final snapshot = await  FirebaseFirestore.instance.
    collection('Client')
        .doc(SignUpController().getCurrentUserUid())
        .collection('cards')
        .doc(cardId)
        .collection('parkingDetails')
        .get();
    final userdata =
    snapshot.docs.map((e) => parkingDetailModel.fromSnapshot(e)).toList();
    return userdata;
  }


  Future<List<parkingDetailModel>> searchFirestore(String searchString ,String cardId) async {
    final snapshot = await  FirebaseFirestore.instance.
    collection('Client')
        .doc(SignUpController().getCurrentUserUid())
        .collection('cards')
        .doc(cardId)
        .collection('parkingDetails')
        .where('Location', isGreaterThanOrEqualTo: searchString)
        .where('Location', isLessThan: searchString + '\uf8ff')
        .get();
    final userdata =
    snapshot.docs.map((e) => parkingDetailModel.fromSnapshot(e)).toList();
    return userdata;
  }

}