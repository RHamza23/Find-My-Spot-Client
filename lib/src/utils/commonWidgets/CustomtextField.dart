import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inpark/src/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? placeholder;
  final IconData? icon;
  final bool secureText;
  final TextEditingController? controller;
  final  TextInputType type;
  final String? Function(String?)? validator;
  String? intialValue;
  final IconButton? suffixIcon;
  CustomTextField({
    required this.label,
     this.placeholder,
    required this.icon,
    required this.secureText,
    this. controller,
    required this.type,
    this.validator,
    this.intialValue, this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          // textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: SecondaryColor,
            fontSize: 15,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          initialValue: intialValue,
          validator: validator,
          controller: controller,
          obscureText: secureText,
          keyboardType: type,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon,
            hintText: placeholder,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}
