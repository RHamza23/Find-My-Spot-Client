import 'package:cloud_firestore/cloud_firestore.dart';

class balanceModel {
  final double balance;

  balanceModel({required this.balance});

  toJason() {
    return {
      "Balance": balance,
    };
  }

  factory balanceModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return balanceModel(balance: data["Balance"]);
  }
}
