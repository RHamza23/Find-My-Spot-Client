import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/colors.dart';

class customElevatedButton extends StatelessWidget {
  const customElevatedButton(
      {Key? key,  required this.text, required this.TextColor, required this.ButtonColor, required this.route,
        // required this.onCustomButtonPressed
      })
      : super(key: key);
  final String  text;
  final Color TextColor;
  final Color ButtonColor;
  final Widget route;
  // final VoidCallbackAction onCustomButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: ElevatedButton(
          onPressed: () {
            Get.to(route);
          },
          child: Text(text ,style: TextStyle(color: TextColor, fontFamily: 'Roboto-Black'),),
        style: ElevatedButton.styleFrom(
          primary: ButtonColor,
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
        )
        ),

      ),
    );
  }
}
