import 'package:flutter/material.dart';
import 'package:inpark/src/constants/colors.dart';

import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import 'headerText.dart';

class headerWithTextandCurve extends StatelessWidget {
  const headerWithTextandCurve({Key? key, required this.headerText, required this.fontsize, required this.imagePath, required this.height}) : super(key: key);

  final String headerText;
  final double fontsize;
  final String imagePath;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Image.asset(
            imagePath,
            color: PrimaryColor,
            width: MediaQuery
                .of(context)
                .size
                .width,
            fit: BoxFit.fill,
            height: MediaQuery
                .of(context)
                .size
                .height / height,
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 50, 0, 0),
              child: headerWidget(
                title:headerText ,
                color: Colors.white, FontSize: fontsize,
              ),
            ),
          )

        ]);
  }
}
