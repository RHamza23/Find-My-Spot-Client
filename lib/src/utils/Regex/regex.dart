


extension Regex on String {
  bool get isNull {
    final nullRegExp = new RegExp(
        r"^\s*$");
    return nullRegExp.hasMatch(this);
  }

  bool get isValidEmail {
    final emailRegExp = RegExp(  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return emailRegExp.hasMatch(this);
  }
  bool get isValidName {
    final nameRegExp = new RegExp(
        r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp =
    RegExp(r"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$");
    return passwordRegExp.hasMatch(this);
  }
  bool get isValidPhone {
    final phoneRegExp =
    RegExp(r"^\d{11}$");
    return phoneRegExp.hasMatch(this);
  }
  bool get isValidVehicleNumber{
    final vehicleNoRegExp =
    RegExp(r"^[A-Z]{3}-\d{4}$");
    return vehicleNoRegExp.hasMatch(this);
  }
  bool get isValidCnicNumber{
    final CnicNoRegExp =
    RegExp(r"^\d{13}$");
    return CnicNoRegExp.hasMatch(this);
  }
  bool get isValidCardId{
    final CnicNoRegExp =
    RegExp(r"^\d{4}$");
    return CnicNoRegExp.hasMatch(this);
  }
}