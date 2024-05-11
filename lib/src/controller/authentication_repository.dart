import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:inpark/src/view/userManagment/SignUp.dart';
import 'package:inpark/src/view/welcome_screen/welcomScreen1.dart';
import '../view/Dashboard/dashboard.dart';

class AuthenticationRepository extends GetxController{
  static  AuthenticationRepository get instance => Get.find();

  //variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => WelcomeScreen()) : Get.offAll(() => const Dashboard());
  }

}

