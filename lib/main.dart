import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inpark/src/controller/authentication_repository.dart';
import 'package:inpark/src/view/splash_Screens/SplashScreen1.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: MaterialColor(
              0xffe4a300,
              <int, Color>{
                50: Color(0x33e4a300),
                100: Color(0x33e4a300),
                200: Color(0x4de4a300),
                300: Color(0x66e4a300),
                400: Color(0x80e4a300),
                500: Color(0x99e4a300),
                600: Color(0xb3e4a300),
                700: Color(0xcce4a300),
                800: Color(0xe6e4a300),
                900: Color(0xffe4a300),
              },
            )),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,

        home: splashScreen());
  }
}
