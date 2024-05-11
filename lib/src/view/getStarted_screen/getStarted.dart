import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inpark/src/constants/colors.dart';
import 'package:inpark/src/constants/text_strings.dart';
import 'package:inpark/src/utils/commonWidgets/ButtonWidget.dart';
import 'package:inpark/src/utils/commonWidgets/headerText.dart';
import '../../constants/image_strings.dart';
import '../userManagment/SignIn.dart';
import '../userManagment/SignUp.dart';

class getStarted extends StatelessWidget {
  const getStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 0, 0),
        child: headerWidget(title: inpark, color: PrimaryColor, FontSize: 60,),
      ),
      Expanded(
        child: SvgPicture.asset(
          SplashImage,
          width: 250,
          height: 250,
        ),
      ),
      Stack(
        children: [
          Image.asset(
            getStartedCurve,
          ),
          Positioned(
              // The Positioned widget is used to position the text inside the Stack widget
              // bottom: 10,
              // right: 0,

              child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: (){Get.to(SignUp());},
                    child: customElevatedButton(
                      text: 'Get Started',
                      TextColor: SecondaryColor,
                      ButtonColor: Colors.white, route: SignUp(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: (){Get.to(SignIn());},
                    child: customElevatedButton(
                      text: 'Login',
                      TextColor: Colors.white,
                      ButtonColor: SecondaryColor, route: SignIn(),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      )
    ],
      ),
    );
  }


}
