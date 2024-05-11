import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inpark/src/constants/colors.dart';
import 'package:inpark/src/model/theftRequestModel.dart';
import 'package:inpark/src/utils/Regex/regex.dart';
import 'package:inpark/src/utils/commonWidgets/CustomtextField.dart';
import 'package:inpark/src/view/Dashboard/dashboard.dart';
import 'package:intl/intl.dart';

import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/requestFormController.dart';

class TheftRequestForm extends StatefulWidget {
  const TheftRequestForm({Key? key}) : super(key: key);

  @override
  State<TheftRequestForm> createState() => _TheftRequestFormState();
}

class _TheftRequestFormState extends State<TheftRequestForm> {
  requestFormController _requestFormController =
      Get.put(requestFormController());
  final _formKey = GlobalKey<FormState>();


  final List<String> vehicleTypes = ['Car', 'Bike'];

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2024));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _requestFormController.theftDateController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          vehcileTheftRequest,
                          style: TextStyle(
                            fontSize: 50,
                            color: SecondaryColor,
                            height: 1.105263157894737,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text(
                          vehicleTheftRequestDescription,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: const Color(0xff312e2e),
                            height: 1.55,
                          ),
                        ),
                      ),


                      SizedBox(height: 20),
                      CustomTextField(
                        label: name,
                        placeholder: tempName,
                        icon: Icons.person,
                        secureText: false,
                        controller: _requestFormController.nameController,
                        type: TextInputType.text,
                        validator: (val) {
                          if (val!.isValidName == false) return 'Enter valid Name';
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                          label: CNIC,
                          placeholder: tempCNIC,
                          icon: Icons.add_card,
                          secureText: false,
                          controller: _requestFormController.cnicController,
                          type: TextInputType.number,
                        validator: (val) {
                          if (val!.isValidCnicNumber == false) return 'Enter valid CNIC Number';
                        },
                      ),
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
                          controller: _requestFormController.vehicleNoController,
                          type: TextInputType.text),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 215),
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
                        value: _requestFormController.vehicleTypeController.text.isNotEmpty
                            ? _requestFormController.vehicleTypeController.text
                            : null,
                        items: vehicleTypes
                            .map((type) =>
                                DropdownMenuItem(child: Text(type), value: type))
                            .toList(),
                        onChanged: (value) {
                          _requestFormController.vehicleTypeController.text = value!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Bike',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Select vehicle Type';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 255),
                        child: Text(
                          "Date",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: SecondaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        onTap: () => _selectDate(context),
                        readOnly: true,
                        controller: _requestFormController.theftDateController,
                        decoration: InputDecoration(
                          hintText: "Select date of Vehicle Theft",
                          suffixIcon: Icon(Icons.calendar_today),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Select Date';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: SecondaryColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _requestFormController.descriptionController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: writeShortDescription,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Description is required';
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              theftRequestModel request = theftRequestModel(
                                  _requestFormController.nameController.text,
                                  _requestFormController.cnicController.text,
                                  _requestFormController.vehicleNoController.text,
                                  _requestFormController.vehicleTypeController.text,
                                  _requestFormController.theftDateController.text,
                                  _requestFormController.descriptionController.text);
                              _requestFormController
                                  .theftRequest(request)
                                  .then((value) => Get.to(Dashboard()));
                            }
                          },
                          child: Text(
                            submit.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(primary: SecondaryColor),
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
}
