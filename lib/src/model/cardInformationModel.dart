import 'package:cloud_firestore/cloud_firestore.dart';

class cardInformationModel {
  String cardId;
  String vehicleNo;
  String model;
  String company;
  String vehicleType;
  String valid;
  String phoneNo;
  String paymentMethod;
  String address;

  cardInformationModel({
    required this.cardId,
    required this.vehicleNo,
    required this.model,
    required this.company,
    required this.vehicleType,
    required this.valid,
    required this.phoneNo,
    required this.paymentMethod,
    required this.address,
  });

  toJason() {
    return {
      "Card Id": cardId,
      "Vehicle No": vehicleNo,
      "Model": model,
      "Company": company,
      "Vehicle Type": vehicleType,
      "Phone No": phoneNo,
      "Payment Method": paymentMethod,
      "Address": address,
      "Card Valid": valid,
    };
  }

  factory cardInformationModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return cardInformationModel(
        cardId: 'Card Id',
        vehicleNo: 'Vehicle No',
        model: 'Model',
        company: 'Company',
        vehicleType: 'Vehicle Type',
        phoneNo: 'Phone No',
        paymentMethod: 'Payment Method',
        address: 'Address',
        valid: 'Card Valid',
    );
  }
}
