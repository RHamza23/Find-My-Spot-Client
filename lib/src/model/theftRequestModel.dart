class theftRequestModel {
  final String Name;
  final String Cnic;
  final String VehicleNo;
  final String VehicleType;
  final String theftDate;
  final String description;

  theftRequestModel(this.Name, this.Cnic, this.VehicleNo, this.VehicleType,
      this.theftDate, this.description);

  toJason() {
    return {
      "name": Name,
      "cnic": Cnic,
      "vehicle_no": VehicleNo,
      "vehicle_type": VehicleType,
      "date": theftDate,
      "complain_description": description
    };
  }
}
