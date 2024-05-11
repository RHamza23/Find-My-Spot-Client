import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:inpark/src/constants/colors.dart';
import 'package:inpark/src/controller/walletController.dart';
import 'package:inpark/src/model/balanceModel.dart';
import 'package:inpark/src/view/Wallet/wallet.dart';

import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../model/walletModel.dart';
import '../../utils/commonWidgets/headerWidget.dart';
import '../profile/setting.dart';

class depositMoney extends StatefulWidget {
  const depositMoney({Key? key}) : super(key: key);

  @override
  State<depositMoney> createState() => _depositMoneyState();
}

class _depositMoneyState extends State<depositMoney> {
  final controller = Get.put(walletController());

  String creditDepit = "Credit/Debit";
  String easypaisa = "Easypaisa";
  String jazzCash = "Jazzcash";
  String? depositMethod;
  TextEditingController depositAmountcontroller = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
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
        child: Column(
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
                          .height/3.8
                  ),
                  Positioned(
                    child: Column(
                        children:[ Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 90),
                            child: Text(
                              deposit ,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 60,
                                  color: Colors.white,
                                  fontFamily: 'Lobster'
                              ),),
                          ),
                        ),
                        ]
                    ),
                  )

                ]),
            SizedBox(
              height: 50,
            ),
            Text(
              depositAmount,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 30,
                color: PrimaryColor,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Amount';
                    }
                    return null;
                  },
                  controller: depositAmountcontroller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1.5, color: SecondaryColor), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: "     Rs: ",
                    hintStyle: TextStyle(
                      color: LightGreyColor,
                      fontSize: 20,
                    ),
                  ),
                  // textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 130),
              child: Text(
                "Deposit Method:",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 25,
                  color: PrimaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  ListTileTheme(
                    horizontalTitleGap: 0,
                    child: RadioListTile(
                    title: Image.asset(creditDepitButton),
                    value: creditDepit,
                    groupValue: depositMethod,
                    onChanged: (value) {
                      setState(() {
                        depositMethod = value.toString();
                      });
                    },
                  ),),

              ListTileTheme(
                horizontalTitleGap: 0,
                child:  RadioListTile(
                    title: Image.asset(easypaisaButton),
                    value: easypaisa,
                    groupValue: depositMethod,
                    onChanged: (value) {
                      setState(() {
                        depositMethod = value.toString();
                      });
                    },
                  ),),

              ListTileTheme(
                horizontalTitleGap: 0,
                child: RadioListTile(
                    title: Image.asset(jazzcashButton),
                    value: jazzCash,
                    groupValue: depositMethod,
                    onChanged: (value) {
                      setState(() {
                        depositMethod = value.toString();
                      });
                    },
                  ),)
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Text('Selected radio button: $depositMethod'),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        depositMethod != null) {
                      final Id = await controller.generateId();
                      print(Id);
                      final deposit = walletModel(
                        amount: depositAmountcontroller.text,
                        depositMethod: depositMethod!,
                        transectionId: Id,
                      );
                      controller.depositMoney(deposit).then((value) =>
                      {
                        controller.updateBalance(
                            depositAmountcontroller.text.trim()).then((value) =>
                        {Get.to(wallet())})
                      });
                    } else {
                      Get.snackbar("Error",
                          "Please Select an Option and Enter some Text",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: PrimaryColor,
                          colorText: Colors.black);
                    }
                  },
                  child: Text(
                    deposit,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: SecondaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
