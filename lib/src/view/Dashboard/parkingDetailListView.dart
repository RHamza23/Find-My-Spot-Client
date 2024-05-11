import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inpark/src/constants/colors.dart';

import '../../constants/image_strings.dart';

class parkingDetailListView extends StatefulWidget {
   String location;
   String timeIn;
   String timeOut;
   String totalTime;
   String fees;

  parkingDetailListView(
      {Key? key,
        required this.location,
        required this.timeIn,
        required this.timeOut,
        required this.totalTime,
        required this.fees

      }): super(key: key);

  @override
  State<parkingDetailListView> createState() => _parkingDetailListViewState();
}

class _parkingDetailListViewState extends State<parkingDetailListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
        child: Container(
          margin: EdgeInsets.all(0.0), // Remove the default tile padding
          child: Stack(
            children: <Widget>[
              ClipRRect(
                child: SvgPicture.asset(
                  parkingDetailCard,
                  width:180,
                  height: 180.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16.0), // Add spacing between the image and text
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                      "Location: " + widget.location ,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                           ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(35, 20, 0, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child:  Text(
                        widget.timeIn ,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 73, 55, 0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      widget.timeOut,
                      style:
                      TextStyle(fontSize: 15,),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 73, 55, 0),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.totalTime,
                      style:
                      TextStyle(fontSize: 15,),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 125, 55, 0),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                    "RS " + widget.fees,
                      style:
                      TextStyle(fontSize: 20,color: PrimaryColor),
                    )),
              ),
            ],
          ),
        ));
  }
}
