import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findmyspot/src/controller/signUp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../model/OrderCardModel.dart';
import '../model/parkingDetailModel.dart';

class  AddVehicleController extends GetxController{

  static AddVehicleController get instance =>  Get.find();
  //variables


  // TextField Controllers to get data from textfields
  final vehiclNoController = TextEditingController();
  final fullnameController = TextEditingController();
  final cardIdController = TextEditingController();

  //call the function from design and it will do the rest


  Future<void> adddCard(String vehicleNo, String name, String cardId) async {
    final Query<Map<String, dynamic>> vehicleCardsRef =
    FirebaseFirestore.instance.collection('Card Orders').where('userId', isEqualTo: SignUpController().getCurrentUserUid().toString()).limit(1);
    final QuerySnapshot<Map<String, dynamic>> cardSnapshot =
    await vehicleCardsRef.get();
    QueryDocumentSnapshot<Map<String, dynamic>> card = cardSnapshot.docs.first;
    if (cardSnapshot.docs.isNotEmpty) {
      final Map<String, dynamic>? data = card.data();
      if (data?['orderData']['vehicle_no'] == vehicleNo && data?['orderData']['name'] == name) {
        final DocumentReference cardsRef =
        FirebaseFirestore.instance.collection('Client').doc(SignUpController().getCurrentUserUid().toString()).collection("cards").doc(cardId);

        await cardsRef.set(data!).whenComplete(()  {
        return Get.snackbar("Success", "Your Card has been successfully added to your account",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: PrimaryColor,
        colorText: Colors.white);

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
        .get();
        print(snapshot.docs.length);
    final userdata =
    snapshot.docs.map((e) => parkingDetailModel.fromSnapshot(e)).toList();
    return userdata;
  }

}