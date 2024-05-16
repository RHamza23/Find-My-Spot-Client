import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inpark/src/constants/colors.dart';
import 'package:inpark/src/controller/profileController.dart';
import 'package:inpark/src/model/UserModel.dart';
import 'package:inpark/src/utils/Regex/regex.dart';

import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/signUp_controller.dart';
import '../../utils/commonWidgets/CustomtextField.dart';
import '../../utils/commonWidgets/headerText.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final controller = Get.put(SignUpController());
  final _profileController = Get.put(profileController());

  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

    File? _imageFile;
  String? _imageUrl;

  String? ImageUrlFromFirebase;

  UserModel user=UserModel(name: "", email: "", phone: "", password: "");

  TextEditingController Email = TextEditingController();
  TextEditingController Fullname = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController PhoneNo = TextEditingController();


  Future _pickImage() async {
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });

    final url = await _profileController.uploadImageAndGetLink(_imageFile!);
    setState(() {
      _imageUrl = url;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  Future get() async
  {
    user= await _profileController.getUserDetails();

    Email.text=user.email;
    Fullname.text=user.name;
    Password.text=user.password;
    PhoneNo.text=user.phone;
    setState(() {
    });
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
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: PrimaryColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 0, 0),
              child: headerWidget(
                title: editProfile,
                color: Colors.white,
                FontSize: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 210),
              child: Image.asset(
                color: Colors.white,
                SignUpCurve,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                fit: BoxFit.fill,
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.31,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 130),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        // _openGallery();
                        _pickImage();
                      },
                      child: Container(
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
                        child: FutureBuilder<Object>(
                            future: _profileController.getUserDetails(),
                          builder: (context, snapshot) {
                              if (snapshot.hasData){
                                UserModel userData = snapshot.data as UserModel;
                                if (userData.profileImage != null && userData.profileImage!.isNotEmpty) {
                                  return ClipOval(
                                    child: Image.network(
                                      userData.profileImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }else{
                                  return ClipOval(
                                      child: SvgPicture.asset(personIcon));
                                }

                              }else if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              else {
                                return const Center(child: CircularProgressIndicator(),);
                              }
                          }
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                  child: Column(
                    children: [
                      ProfileForm(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ProfileForm() {
    // return Container(
      // child: FutureBuilder(
      //     builder: (context, snapshot) {

          if(user!=null)
            {
              return Container(
                child: Column(
                    children:[

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: Fullname,
                              label: name,
                              // placeholder: userData.name,
                              icon: Icons.person_outline_rounded,
                              secureText: false,
                              type: TextInputType.text,
                              validator: (val) {
                                if (val!.isValidName == false)
                                  return 'Enter valid Name';
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: Email,
                              label: email,
                              icon: Icons.email_outlined,
                              secureText: false,
                              type: TextInputType.emailAddress,
                              validator: (val) {
                                if (val!.isValidEmail == false)
                                  return 'Enter valid email';
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: PhoneNo,
                              label: phone,
                              icon: Icons.numbers,
                              secureText: false,
                              type: TextInputType.phone,
                              validator: (val) {
                                if (val!.isValidPhone == false)
                                  return 'Enter valid Phone';
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              controller: Password,
                              label: password,
                              icon: Icons.password,
                              secureText: false,
                              type: TextInputType.text,
                              validator: (val) {
                                if (controller.password
                                    .toString()
                                    .isEmpty) {
                                  return 'Please enter some text';
                                }
                                if (val!.isValidPassword == false)
                                  return ' Password should contain A,a ,123';
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Update user data in Firebase Firestore
                                    final userData = UserModel(
                                        id: SignUpController.instance.getCurrentUserUid().toString(),
                                        name: Fullname.text.trim(),
                                        email: Email.text.trim(),
                                        phone: PhoneNo.text.trim(),
                                        password: Password.text.trim(),
                                        profileImage: user.profileImage.toString(),
                                    );
                                    await _profileController.updateUserRecord(
                                        userData);
                                  }
                                  setState(() {

                                  });
                                },
                                child: Text(
                                  update.toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                style:
                                ElevatedButton.styleFrom(primary: SecondaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),]
                ),
              );

            }
            else {
              return const Center(child: CircularProgressIndicator(),);
            }
          // } else {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
        // },
      // ),
    // );
  }
}
