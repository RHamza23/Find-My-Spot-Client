import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:findmyspot/src/utils/Regex/regex.dart';
import 'package:findmyspot/src/view/Dashboard/parkingDetails.dart';
import 'package:findmyspot/src/view/profile/setting.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/addVehicle_controller.dart';
import '../../utils/commonWidgets/CustomBottomNavigationBarWithWallet.dart';
import '../../utils/commonWidgets/CustomtextField.dart';
import '../../utils/commonWidgets/FloatingactionButtonWithNotched.dart';
import '../card/orderCard.dart';
import 'dashboardListview.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: []);
  }

  final _formKey = GlobalKey<FormState>();
  AddVehicleController controller = Get.put(AddVehicleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButtonWithNotched(
          onClickAction: () {
            showModalBottomSheet(
                backgroundColor: Colors.white.withOpacity(1),
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                builder: (context) => Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Container(
                        height: MediaQuery.of(context).size.height * 0.645,
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Add Your Vehicle",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            AddVehicleForm(),
                          ],
                        ),
                      ),
                ),
            );
          },
          Icon: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          )),
      bottomNavigationBar: CustomNavigationBar1(
          icon: Icons.person_outline,
          onClick2ndicon: () {
            Get.to(setting());
          }),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
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
                      // height: MediaQuery
                      //     .of(context)
                      //     .size
                      //     .height/4
                  ),
                  Column(
                      children:[ Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Text(
                            yourCards ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 55,
                                color: Colors.white,
                                fontFamily: 'Lobster'
                            ),),
                        ),
                      ),
                      ]
                  )

                ]),
            SizedBox(height:30,),
            FutureBuilder(
                future: controller.getCardsDetails(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          physics: ClampingScrollPhysics(),
                          reverse: true,
                          itemBuilder: (c, index) {
                            return InkWell(
                              onTap:(){
                                Get.to( parkingDetails( cardId: snapshot.data![index].cardId, vehicleNo: snapshot.data![index].vehicleNo,));
                                },
                              child: cardListView(
                                name: "${snapshot.data![index].name}",
                                vehicleNumber: "${snapshot.data![index].vehicleNo}",
                                vehicleType: "${snapshot.data![index].vehicleType}",
                                vehicleCompany: "${snapshot.data![index].company}",
                                cardId: "${snapshot.data![index].cardId}",
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


          ],
        ),
      ),
    );
  }

  Container AddVehicleForm() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: vehicleNumber,
              placeholder: tempVehicleNumber,
              icon: Icons.car_crash_sharp,
              secureText: false,
              controller: controller.vehiclNoController,
              type: TextInputType.text,
              validator: (val) {
                if (val!.isValidVehicleNumber == false)
                  return 'Enter valid Vehicle Number';
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: name,
              placeholder: tempName,
              icon: Icons.person,
              secureText: false,
              controller: controller.fullnameController,
              type: TextInputType.text,
              validator: (val) {
                if (val!.isValidName == false) return 'Enter valid Name';
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: cardId,
              placeholder: tempCardId,
              icon: Icons.perm_identity,
              secureText: false,
              controller: controller.cardIdController,
              type: TextInputType.number,
              validator: (val) {
                if (val!.isValidCardId == false)
                  return 'Enter valid Card ID';
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.adddCard(
                        controller.vehiclNoController.text,
                        controller.fullnameController.text,
                        controller.cardIdController.text);
                  }

                },
                child: Text(
                  add.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(primary: SecondaryColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(const OrderCard());
              },
              child: const Text(
                dontHaveCard,
                style: TextStyle(
                  fontSize: 15,
                  color: SecondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
