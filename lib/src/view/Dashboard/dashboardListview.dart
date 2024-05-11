import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/image_strings.dart';

class cardListView extends StatefulWidget {
  String name;
  String vehicleNumber;
  String vehicleType;
  String vehicleCompany;
  String cardId;

  cardListView(
      {Key? key,
      required this.name,
      required this.vehicleNumber,
      required this.vehicleType,
      required this.vehicleCompany,
      required this.cardId})
      : super(key: key);

  @override
  State<cardListView> createState() => _cardListViewState();
}

class _cardListViewState extends State<cardListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 0, 20),
        child: Container(
          margin: EdgeInsets.all(0.0), // Remove the default tile padding
          child: Stack(
            children: <Widget>[
              ClipRRect(
                child: SvgPicture.asset(
                  inparkCard,
                  width: 180.0,
                  height: 180.0,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.vehicleType+ ": "+ widget.vehicleCompany,
                        style: const TextStyle(
                            fontFamily: 'Roboto-Bold',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.vehicleNumber,
                        style: const TextStyle(
                            fontFamily: 'Roboto-Bold',
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                            fontFamily: 'Roboto-Bold',
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // SizedBox(height: 4.0),

                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 40, 0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      widget.cardId,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    )),
              ),
            ],
          ),
        ));
  }
}
