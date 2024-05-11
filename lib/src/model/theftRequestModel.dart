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
      "Name": Name,
      "Cnic": Cnic,
      "Vehicle No": VehicleNo,
      "Vehicle Type": VehicleType,
      "Date": theftDate,
      "Complain Description": description
    };
  }
}
