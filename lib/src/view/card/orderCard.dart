import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:findmyspot/src/controller/orderCardController.dart';
import 'package:findmyspot/src/model/OrderCardModel.dart';
import 'package:findmyspot/src/model/UserModel.dart';
import 'package:findmyspot/src/utils/Regex/regex.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/profileController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class OrderCard extends StatefulWidget {
  const OrderCard({Key? key}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                requestFormCurves,
                color: PrimaryColor,
                height: 150,
                width: 140,
              ),
            ),
            // headerWithTextandCurve(headerText: orderCard, fontsize: 50, imagePath: topCurve, height: 3.5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  orderCard.toUpperCase(),
                  style: TextStyle(
                    fontSize: 50,
                    color: SecondaryColor,
                    height: 1.105263157894737,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                orderCardDescriptiion,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: const Color(0xff312e2e),
                  height: 1.55,
                ),
              ),
            ),
            VehicleForm(),
          ],
        ),
      ),
    );
  }
}

class VehicleForm extends StatefulWidget {
  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  final List<String> vehicleTypes = ['Car', 'Bike'];

  final List<String> paymentMethods = [
    'findmyspot Wallet',
    'easypaisa',
    'jazzcash',
    'Debit/Credit Card'
  ];

  final List<String> ModelList = [
    '23',
    '22',
    '21',
    '20',
    '19',
    '18',
    '17',
    '16',
    '15',
    '14',
    '13',
    '12',
    '11',
    '10',
    '09',
    '08',
    '07',
    '06',
    '05',
    '04',
    '03',
    '02',
    '01',
  ];

  final List<String> VehicleCompanyList = [
    'Hundai',
    'MG',
    'Toyota',
    'Suzuki',
    'Proton',
    'Honda',
    'Road Prince',
    'United',
    'Yamaha',
    'Kia',
  ];

  final _formKey = GlobalKey<FormState>();

  final controller = Get.put(OrderCardController());

  profileController _profileController = Get.put(profileController());

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  vehicleNumber,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: SecondaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.vehicleNumberController,
                decoration: InputDecoration(
                  labelText: tempVehicleNumber,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                validator: (val) {
                  if (val!.isValidVehicleNumber == false)
                    return 'Enter valid Vehicle Number';
                },
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  model,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: SecondaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField(
                value: controller.modelController.text.isNotEmpty
                    ? controller.modelController.text
                    : null,
                items: ModelList.map((type) =>
                    DropdownMenuItem(child: Text(type), value: type)).toList(),
                onChanged: (value) {
                  controller.modelController.text = value!;
                },
                decoration: InputDecoration(
                  labelText: 'Model',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Select vehicle Model';
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  company,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: SecondaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                value: controller.companyController.text.isNotEmpty
                    ? controller.companyController.text
                    : null,
                items: VehicleCompanyList.map((type) =>
                    DropdownMenuItem(child: Text(type), value: type)).toList(),
                onChanged: (value) {
                  controller.companyController.text = value!;
                },
                decoration: InputDecoration(
                  labelText: 'Company',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Select Vehicle Company';
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  VehicleType,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: SecondaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                value: controller.vehicleTypeController.text.isNotEmpty
                    ? controller.vehicleTypeController.text
                    : null,
                items: vehicleTypes
                    .map((type) =>
                    DropdownMenuItem(child: Text(type), value: type))
                    .toList(),
                onChanged: (value) {
                  controller.vehicleTypeController.text = value!;
                },
                decoration: InputDecoration(
                  labelText: 'Vehicle Type',
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
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  phone,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: SecondaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.phoneNoController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: tempPhone,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                validator: (val) {
                  if (val!.isValidPhone == false)
                    return 'Enter valid Phone Number';
                },
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  paymentMethod,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: SecondaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                value: controller.paymentMethodController.text.isNotEmpty
                    ? controller.paymentMethodController.text
                    : null,
                items: paymentMethods
                    .map((method) =>
                    DropdownMenuItem(child: Text(method), value: method))
                    .toList(),
                onChanged: (value) {
                  controller.paymentMethodController.text = value!;
                },
                decoration: InputDecoration(
                  labelText: 'Payment Method',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Select payment Method';
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  address,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: SecondaryColor,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: controller.addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Address';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      String id = await controller.generateUniqueID();
                      bool exists = await controller.checkVehicleExists(
                          controller.vehicleNumberController.text.trim());
                      UserModel user =
                      await _profileController.getUserDetails();
                      if (exists) {
                        Get.snackbar("Error", "Vehicle already exist",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: PrimaryColor,
                            colorText: Colors.black);
                      } else {
                        final orderdetail = OrderCardModel(
                            uuid: controller.getCurrentUserUid().toString(),
                            name: user.name,
                            email: user.email,
                            cardId: id,
                            vehicleNo:
                            controller.vehicleNumberController.text.trim(),
                            model: controller.modelController.text.trim(),
                            company: controller.companyController.text.trim(),
                            vehicleType:
                            controller.vehicleTypeController.text.trim(),
                            phoneNo: controller.phoneNoController.text.trim(),
                            paymentMethod:
                            controller.paymentMethodController.text.trim(),
                            address: controller.addressController.text.trim(),
                            valid: "12/27",
                            orderStatus: "Order Confirmed");
                        OrderCardController.instance.deductCardFee(orderdetail)
                            .then((value) =>
                        {
                        setState(() {
                        _loading = false;
                        })
                        });
                      }
                    }
                  },
                  child: Text(
                    orderNow.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: SecondaryColor),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

// Function to generate 4-digit number ID
  int generateRandomId() {
    Random random = Random();
    int id = random.nextInt(9000) +
        1000; // Generates a random number between 1000 and 9999
    return id;
  }

// Function to check if ID exists in Firestore database
  Future<bool> checkIdExists(int id) async {
    final CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(
        'Admin'); // Replace 'your_collection_name' with the name of your collection in Firestore
    final QuerySnapshot snapshot = await collectionReference
        .where('Card Id', isEqualTo: id)
        .limit(1)
        .get();
    return snapshot.docs.isNotEmpty;
  }

// Function to generate 4-digit number ID after checking its existence in Firestore
  Future<int> generateUniqueId() async {
    int id;
    bool idExists;
    do {
      id = generateRandomId();
      idExists = await checkIdExists(id);
    } while (idExists); // Regenerate ID if it already exists in Firestore
    return id;
  }
}
