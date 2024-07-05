import 'package:flutter/material.dart';
import 'package:findmyspot/src/constants/colors.dart';

class headerWidget extends StatelessWidget {
  const headerWidget({Key? key, required this.title, required this.color, required this.FontSize,}) : super(key: key);

  final String title ;
  final Color color;
  final double FontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, textAlign: TextAlign.center, style: TextStyle(color: color , fontSize: FontSize, fontWeight: FontWeight.normal ,fontFamily: 'Lobster')),
        ],
      ),
    );
  }
}