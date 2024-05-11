import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCardModel {
  final String uuid;
  final String name;
  final String email;
  final String cardId;
  final String vehicleNo;
  final String model;
  final String company;
  final String vehicleType;
  final String phoneNo;
  final String paymentMethod;
  final String address;
  final String valid;
  final String orderStatus;

  OrderCardModel({
    required this.uuid,
    required this.name,
    required this.email,
    required this.cardId,
    required this.vehicleNo,
    required this.model,
    required this.company,
    required this.vehicleType,
    required this.phoneNo,
    required this.paymentMethod,
    required this.address,
    required this.valid,
    required this.orderStatus,
  } );

  toJason() {
    return {
    "UUID":uuid,
     "Name":name,
      "Email" : email,
     "Card Id":cardId,
     "Vehicle No":vehicleNo,
     "Model":model,
     "Company":company,
     "Vehicle Type":vehicleType,
     "Phone No":phoneNo,
     "Payment Method":paymentMethod,
     "Address":address,
     "Card Valid":valid,
     "Order Status":orderStatus,




    };
  }

  factory OrderCardModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return OrderCardModel(
        uuid: data["UUID"],
        name: data["Name"],
        email: data["Email"],
      cardId: data["Card Id"],
      vehicleNo: data["Vehicle No"],
      model: data["Model"],
      company: data["Company"],
      vehicleType: data["Vehicle Type"],
      phoneNo: data["Phone No"],
      paymentMethod: data["Payment Method"],
      address: data["Address"],
      valid: data["Card Valid"],
      orderStatus: data["Order Status"],



    );
  }
}
