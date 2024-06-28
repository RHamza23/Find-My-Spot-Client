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
      "name":name,
      "email" : email,
      "card_id":cardId,
      "vehicle_no":vehicleNo,
      "model":model,
      "company":company,
      "vehicle_type":vehicleType,
      "phone_no":phoneNo,
      "payment_method":paymentMethod,
      "address":address,
      "card_valid":valid,
      "order_status":orderStatus,




      };
    }

    factory OrderCardModel.fromSnapshot(
        DocumentSnapshot<Map<String, dynamic>> document) {
      final data = document.data()!;
      return OrderCardModel(
          uuid: data['orderData']["UUID"],
          name: data['orderData']["name"],
          email: data['orderData']["email"],
        cardId: data['orderData']["card_id"],
        vehicleNo: data['orderData']["vehicle_no"],
        model: data['orderData']["model"],
        company: data['orderData']["company"],
        vehicleType: data['orderData']["vehicle_type"],
        phoneNo: data['orderData']["phone_no"],
        paymentMethod: data['orderData']["payment_method"],
        address: data['orderData']["address"],
        valid: data['orderData']["card_valid"],
        orderStatus: data['orderData']["order_status"],
      );
    }
  }
