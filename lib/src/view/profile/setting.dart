import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inpark/src/view/RequestForms/RequestVehicleForm.dart';
import 'package:inpark/src/view/profile/profile.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/profileController.dart';
import '../../model/UserModel.dart';
import '../../utils/commonWidgets/CustomBottomNavigationBarWithWallet.dart';
import '../../utils/commonWidgets/FloatingactionButtonWithNotched.dart';
import '../../utils/commonWidgets/headerWidget.dart';
import '../RequestForms/TheftRequestForm.dart';
import '../Wallet/wallet.dart';
import '../userManagment/SignIn.dart';

class setting extends StatefulWidget {
  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;

    profileController _profileController = Get.put(profileController());

    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        bottomNavigationBar: CustomNavigationBar1(
            icon: Icons.account_balance_wallet_outlined,
            onClick2ndicon: () {
              Get.to(wallet());
            }),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton:
            FloatingActionButtonWithNotched(onClickAction: () {}),
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
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              headerWithTextandCurve(
                headerText: yourProfile,
                fontsize: 40,
                imagePath: topCurveWithLength,
                height: 1.9,
              ),
              Positioned(
                  child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/3,
                        child: FutureBuilder(
                          future: _profileController.getUserDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                UserModel userData = snapshot.data as UserModel;
                                if (userData.profileImage != null && userData.profileImage!.isNotEmpty) {
                               return Column(
                                 children: [
                                   Container(
                                       width: 150,
                                       height: 150,
                                       decoration: BoxDecoration(
                                         shape: BoxShape.circle,
                                         color: Colors.grey[700],
                                         border: Border.all(
                                             color: Colors.white,
                                             width: 5.0,
                                             style: BorderStyle.solid),
                                       ),
                                       child: ClipOval(
                                         child: Image.network(
                                           userData.profileImage!,
                                           fit: BoxFit.cover,
                                         ),
                                       )
                                   ),

                                   SizedBox(height: 10),
                                   Text(
                                     userData.name,
                                     style: TextStyle(
                                         fontSize: 25,
                                         fontWeight: FontWeight.bold,
                                         color: Colors.white,
                                         fontFamily: 'Roboto'),
                                   ),
                                   SizedBox(height: 5),
                                   Text(
                                     userData.email,
                                     style: TextStyle(
                                         fontSize: 16, color: Colors.white),
                                   ),
                                   SizedBox(height: 40),
                                 ],
                               );
                                }
                                else{
                                  return Column(
                                    children: [
                                      Container(
                                          width: 150,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[700],
                                            border: Border.all(
                                                color: Colors.white,
                                                width: 5.0,
                                                style: BorderStyle.solid),
                                          ),
                                          child: ClipOval(
                                            child: SvgPicture.asset(personIcon)
                                          )
                                      ),

                                      SizedBox(height: 10),
                                      Text(
                                        userData.name,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Roboto'),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        userData.email,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                      SizedBox(height: 40),
                                    ],
                                  );
                                }
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: CircularProgressIndicator()
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(wallet());
                          // print(_signUpController.getCurrentUserUid());
                        },
                        child: Text(
                          'MY WALLET',
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                          backgroundColor: PrimaryColor,
                        ),
                      ),
                      SizedBox(height: 3),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: 60,
                                width: 350,
                                child: IconButton(
                                    onPressed: () {
                                      Get.to(RequestVehicleForm());
                                    },
                                    icon:
                                        SvgPicture.asset(requestVehicleButton))),
                            Container(
                                height: 60,
                                width: 350,
                                child: IconButton(
                                    onPressed: () {
                                      Get.to(TheftRequestForm());
                                    },
                                    icon: SvgPicture.asset(theftRequestButton))),
                            Container(
                                height: 60,
                                width: 350,
                                child: IconButton(
                                    onPressed: () {
                                      Get.to(profile());
                                    },
                                    icon: SvgPicture.asset(editProfileButton))),
                            Container(
                                height: 60,
                                width: 350,
                                child: IconButton(
                                    onPressed: () {
                                      _auth
                                          .signOut()
                                          .then((value) => Get.to(SignIn()));
                                    },
                                    icon: SvgPicture.asset(logoutButton))),
                          ]),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ));
  }
}
