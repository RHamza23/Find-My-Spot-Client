import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inpark/src/constants/colors.dart';
import 'package:inpark/src/model/parkingDetailModel.dart';
import 'package:inpark/src/view/Dashboard/parkingDetailListView.dart';

import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/addVehicle_controller.dart';
import '../../model/OrderCardModel.dart';
import '../../utils/commonWidgets/CustomBottomNavigationBarWithWallet.dart';
import '../../utils/commonWidgets/FloatingactionButtonWithNotched.dart';
import '../../utils/commonWidgets/headerText.dart';
import '../../utils/commonWidgets/headerWidget.dart';
import '../Wallet/wallet.dart';
import '../profile/setting.dart';
import 'dashboardListview.dart';

class parkingDetails extends StatefulWidget {
  final String cardId, vehicleNo;

  const parkingDetails(
      {Key? key, required this.cardId, required this.vehicleNo})
      : super(key: key);

  @override
  State<parkingDetails> createState() => _parkingDetailsState();
}

class _parkingDetailsState extends State<parkingDetails> {
  AddVehicleController controller = Get.put(AddVehicleController());
  String _searchString = '';
  TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _searchString = _searchController.text;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
       bottomNavigationBar: CustomNavigationBar1(
          icon: Icons.account_balance_wallet_outlined,
          onClick2ndicon: () {
            Get.to(wallet());
          }),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButtonWithNotched(onClickAction: () {
        Get.to(setting());
      }),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // adjust padding for height of keyboard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Stack(
          children: [
          SvgPicture.asset(
            rectangleCurve,
            width: MediaQuery
                .of(context)
                .size
                .width,
            fit: BoxFit.fill,
            height: MediaQuery
                .of(context)
                .size
                .height/3.5
          ),
            Positioned(
              child: Column(
                 children:[ Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 90),
                    child: Text(
                      widget.vehicleNo ,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold

                      ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: SizedBox(
                    height: 45,
                    child: CupertinoSearchTextField(
                      prefixIcon: Icon(Icons.search, color: PrimaryColor, size: 25,),
                      prefixInsets: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      controller: _searchController,
                    ),
                  ),

                )
                 ]
              ),
            )

            ]),
            SizedBox(height: 30,),
              FutureBuilder(
                future: controller.searchFirestore(_searchString, widget.cardId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount:snapshot.data!.length,
                      physics: ClampingScrollPhysics(),
                      reverse: true,
                      itemBuilder: (c, index) {
                        return InkWell(
                            onTap: () {
                              print(_searchString);
                            },
                            child: parkingDetailListView(
                              location: "${snapshot.data![index].location}",
                              timeIn: snapshot.data![index].timeIn,
                              timeOut: snapshot.data![index].timeOut,
                              totalTime: "${snapshot.data![index].totalTime}",
                              fees: "${snapshot.data![index].fees}",
                            ));
                      });
                },
              )


            ],
          ),
        ),
      ),
    );
  }
}
