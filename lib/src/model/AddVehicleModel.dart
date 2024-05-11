class AddVehicleModel {
  final String vehicleNo;
  final String name;
  final String cardId;

  AddVehicleModel(this.vehicleNo, this.name, this.cardId,);

  toJason() {
    return {
      "Vehicle No": vehicleNo,
      "Name": name,
      "Card Id": cardId,
    };
  }
}
