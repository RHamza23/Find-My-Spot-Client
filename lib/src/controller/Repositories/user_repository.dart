import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inpark/src/model/UserModel.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
   await _db.collection("Client").add(user.toJason()).whenComplete(
        () => Get.snackbar("Success", "Your account has been created",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green
        )
    ).catchError((error, stackTrace){
      Get.snackbar("Error", "Something went wrong. Try Again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red
      );
    });
  }

  String getCurrentUserUid()  {
    final user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      throw Exception("No signed-in user.");
    }
  }
}
