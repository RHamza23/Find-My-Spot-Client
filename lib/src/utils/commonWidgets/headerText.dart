import 'package:flutter/material.dart';
import 'package:inpark/src/constants/colors.dart';

class headerWidget extends StatelessWidget {
  const headerWidget({Key? key, required this.title, required this.color, required this.FontSize,}) : super(key: key);

  final String title ;
  final Color color;
  final double FontSize;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(75, 30, 75, 0),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: color , fontSize: FontSize, fontWeight: FontWeight.normal ,fontFamily: 'Lobster')),
        ],
      ),
    );
  }
}