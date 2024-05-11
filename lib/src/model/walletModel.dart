import 'package:cloud_firestore/cloud_firestore.dart';

class walletModel {
  final String amount;
  final String depositMethod;
  final String transectionId;

  walletModel(
      {
        required this.amount,
      required this.depositMethod,
      required this.transectionId});

  toJason() {
    return {
      "Amount": amount,
      "Deposit Method": depositMethod,
      "Transection Id": transectionId,
    };
  }

  factory walletModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return walletModel(
        amount: data["Amount"],
        depositMethod: data["Deposit Method"],
        transectionId: data["Transection Id"]);
  }
}
