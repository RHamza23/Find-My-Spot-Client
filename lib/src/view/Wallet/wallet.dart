// git hub
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:findmyspot/src/constants/colors.dart';
import 'package:findmyspot/src/constants/text_strings.dart';
import 'package:findmyspot/src/utils/commonWidgets/CustomBottomNavigationBarWithWallet.dart';
import 'package:findmyspot/src/view/profile/setting.dart';
import '../../constants/image_strings.dart';
import '../../controller/profileController.dart';
import '../../controller/walletController.dart';
import '../../model/UserModel.dart';
import '../../utils/commonWidgets/FloatingactionButtonWithNotched.dart';
import '../../utils/commonWidgets/headerWidget.dart';
import 'Deposit.dart';

class wallet extends StatefulWidget {
  const wallet({Key? key}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  profileController _profileController = Get.put(profileController());
  walletController _walletController = Get.put(walletController());

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: FloatingActionButtonWithNotched(onClickAction: () {
        Get.to(setting());
      }),
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
              headerText: "",
              fontsize: 0,
              imagePath: topCurveWithLength,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 110, 0, 0),
              child: Column(children: [
                FutureBuilder(
                  future: _profileController.getUserDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        UserModel userData = snapshot.data as UserModel;
                        return Align(
                          alignment: Alignment.center,
                          child: Column(children: [
                            Text(
                              userData.name,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 25,
                                color: Colors.white,
                                letterSpacing: 4,
                                fontWeight: FontWeight.w700,
                                height: 0.625,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              userData.email,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 15,
                                color: Colors.white,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w700,
                                height: 0.625,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 130,
                              width: 240,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    balance,
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      color: PrimaryColor,
                                      letterSpacing: 2,
                                      fontWeight: FontWeight.w700,
                                      height: 0.625,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FutureBuilder(
                                      future: _walletController.getBalance(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          if (snapshot.hasData) {
                                            // balanceModel balanceData = snapshot.data as balanceModel;
                                            return Text(
                                              'RS: ${snapshot.data}',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 30,
                                                color: SecondaryColor,
                                                letterSpacing: 2,
                                                fontWeight: FontWeight.w700,
                                                height: 0.625,
                                              ),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  snapshot.error.toString()),
                                            );
                                          } else {
                                            return const Center(
                                              child:
                                                  Text("Something went Wrong"),
                                            );
                                          }
                                        } else {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                      height: 30,
                                      width: 100,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Get.to(depositMoney());
                                          },
                                          child: Text(
                                            deposit,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                          
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                  latestTransection,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    height: 1.12,
                                  ),
                                  textHeightBehavior: TextHeightBehavior(
                                      applyHeightToFirstAscent: false),
                                  softWrap: false,
                                ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            FutureBuilder(
                                future: _walletController.getTransections(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.length,
                                          physics: ClampingScrollPhysics(),
                                          reverse: true,
                                          itemBuilder: (c, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    title: Text(
                                                        "Bank Transfer - ${snapshot.data![index].depositMethod}"),
                                                    subtitle: Text(
                                                        "Recieved Payment"),
                                                    textColor: Colors.black,
                                                    leading: Icon(
                                                      Icons
                                                          .circle_notifications_sharp,
                                                      color: PrimaryColor,
                                                      size: 40,
                                                    ),
                                                    trailing: Text(
                                                      "Rs: ${snapshot.data![index].amount}",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      side: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text(snapshot.error.toString()),
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
                                }),
                          ]),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else {
                        return const Center(
                          child: Text("Something went Wrong"),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
