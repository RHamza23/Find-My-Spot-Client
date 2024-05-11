import 'package:cloud_firestore/cloud_firestore.dart';

class parkingDetailModel {
  final String location;
  final String timeIn;
  final String timeOut;
  final String totalTime;
  final String fees;

  parkingDetailModel( {required this.location, required this.timeIn, required this.timeOut, required this.totalTime, required this.fees});

  toJason() {
    return {
      "Location": location,
      "Time In": timeIn,
      "Time Out": timeOut,
      "Total Time": totalTime,
      "Fees": fees,
    };
  }

  factory parkingDetailModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return parkingDetailModel(
        location: data["Location"],
        timeIn: data["Time In"],
        timeOut: data["Time Out"],
        totalTime: data["Total Time"],
        fees: data["Fees"]
    );
  }
}
