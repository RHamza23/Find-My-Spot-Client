import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:findmyspot/src/constants/image_strings.dart';

import '../../constants/colors.dart';

Widget FloatingActionButtonWithNotched  ({required Function onClickAction,  Icon? Icon ,Image? iconImage})  {
  return FloatingActionButton(

    heroTag: null,
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: FloatingActionButton(
            backgroundColor: PrimaryColor,
            hoverElevation: 10,
            foregroundColor: Colors.black54,
            elevation: 4,
            child: Icon != null ? Icon : SvgPicture.asset(personIcon),
            onPressed: () {
              onClickAction();
            }
        ),
      ),);
}