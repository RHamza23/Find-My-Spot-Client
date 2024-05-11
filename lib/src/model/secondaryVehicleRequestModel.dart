import 'package:cloud_firestore/cloud_firestore.dart';

class secondaryVehicleRequestModel {
  final String ownerName;
  final String ownerCnic;
  final String OwnerVehicleNo;
  final String ownerVehicleType;
  final String parkingManagerEmail;
  final String existingVehicle;
  final String id;
  final DateTime time;

  secondaryVehicleRequestModel(
    this.ownerName,
    this.ownerCnic,
    this.OwnerVehicleNo,
    this.ownerVehicleType, this.parkingManagerEmail, this.id, this.existingVehicle, this.time,
  );

  toJason() {
    return {
      "Owner Name": ownerName,
      "Owner Cnic": ownerCnic,
      "Owner Vehicle Number": OwnerVehicleNo,
      "Owner Vehicle Type": ownerVehicleType,
      "Email Parking Manager": parkingManagerEmail,
      "Existing Vehicle": existingVehicle,
      "Id": id,
      "Time": time.millisecondsSinceEpoch,
    };
  }
}
