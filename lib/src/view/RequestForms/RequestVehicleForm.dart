import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inpark/src/constants/colors.dart';
import 'package:inpark/src/model/secondaryVehicleRequestModel.dart';
import 'package:inpark/src/utils/Regex/regex.dart';
import 'package:inpark/src/utils/commonWidgets/CustomtextField.dart';
import 'package:inpark/src/view/Dashboard/dashboard.dart';

import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/requestFormController.dart';
import '../../controller/signUp_controller.dart';

class RequestVehicleForm extends StatefulWidget {
  const RequestVehicleForm({Key? key}) : super(key: key);

  @override
  State<RequestVehicleForm> createState() => _RequestVehicleFormState();
}

class _RequestVehicleFormState extends State<RequestVehicleForm> {
  requestFormController _requestFormController =
      Get.put(requestFormController());
  final _formKey = GlobalKey<FormState>();
  final List<String> vehicleTypes = ['Car', 'Bike'];

  @override
  void dispose() {
    super.dispose();
  }

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
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                requestFormCurves,
                height: 150,
                width: 140,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            requestForVehicle,
                            style: TextStyle(
                              fontSize: 50,
                              color: SecondaryColor,
                              height: 1.105263157894737,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                            validator: (val) {
                              if (val!.isValidName == false) return 'Enter valid Name';
                            },
                            label: ownerName,
                            placeholder: tempName,
                            icon: Icons.person,
                            secureText: false,
                            controller:
                                _requestFormController.ownerNameController,
                            type: TextInputType.text),
                        SizedBox(height: 20),
                        CustomTextField(
                            validator: (val) {
                              if (val!.isValidCnicNumber == false) return 'CNIC Should be 13 digit';
                            },
                            label: ownerCnic,
                            placeholder: tempCNIC,
                            icon: Icons.add_card,
                            secureText: false,
                            controller:
                                _requestFormController.ownerCnicController,
                            type: TextInputType.number),
                        SizedBox(height: 20),
                        CustomTextField(
                            validator: (val) {
                              if (val!.isValidVehicleNumber == false)
                                return 'Enter valid Vehicle Number';
                            },
                            label: vehicleNumber,
                            placeholder: tempVehicleNumber,
                            icon: Icons.car_crash_rounded,
                            secureText: false,
                            controller: _requestFormController
                                .ownerVehicleNumberController,
                            type: TextInputType.text),
                        SizedBox(height: 20),
                        CustomTextField(
                            validator: (val) {
                              if (val!.isValidVehicleNumber == false)
                                return 'Enter valid Vehicle Number';
                            },
                            label: "Permanent vehicle No",
                            placeholder: tempVehicleNumber,
                            icon: Icons.car_crash_rounded,
                            secureText: false,
                            controller: _requestFormController
                                .existingVehicleNumberController,
                            type: TextInputType.text),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 200),
                          child: Text(
                            'Vehicle Type',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: SecondaryColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField(
                          value: _requestFormController
                                  .ownerVehicleTypeController.text.isNotEmpty
                              ? _requestFormController
                                  .ownerVehicleTypeController.text
                              : null,
                          items: vehicleTypes
                              .map((type) => DropdownMenuItem(
                                  child: Text(type), value: type))
                              .toList(),
                          onChanged: (value) {
                            _requestFormController
                                .ownerVehicleTypeController.text = value!;
                          },
                          decoration: InputDecoration(
                            hintText: 'Bike',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Select vehicle Type';
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                            validator: (val) {
                              if (val!.isValidEmail == false)
                                return 'Enter valid Vehicle Number';
                            },
                            label: email,
                            placeholder: tempEmail,
                            icon: Icons.email_outlined,
                            secureText: false,
                            controller: _requestFormController
                                .parkingManagerEmailController,
                            type: TextInputType.emailAddress),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                              String documentID = generateRandomNumber().toString();
                                secondaryVehicleRequestModel request =
                                    secondaryVehicleRequestModel(
                                        _requestFormController
                                            .ownerNameController.text,
                                        _requestFormController
                                            .ownerCnicController.text,
                                        _requestFormController
                                            .ownerVehicleNumberController.text,
                                        _requestFormController
                                            .ownerVehicleTypeController.text,
                                        _requestFormController
                                            .parkingManagerEmailController
                                            .text,
                                      documentID,
                                        _requestFormController
                                            .existingVehicleNumberController.text,
                                      DateTime.now(),


                                    );
                                _requestFormController
                                    .requestForSecondaryVehicle(request, documentID)
                                    .then((value) =>{});
                              }
                            },
                            child: Text(
                              submit.toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: SecondaryColor),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  int generateRandomNumber() {
    Random random = Random();
    int min = 100000000; // Smallest 9-digit number
    int max = 999999999; // Largest 9-digit number
    int randomNumber = min + random.nextInt(max - min);

    return randomNumber;
  }
}
