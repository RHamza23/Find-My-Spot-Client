import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:findmyspot/src/controller/signUp_controller.dart';
import 'package:findmyspot/src/model/UserModel.dart';
import 'package:findmyspot/src/view/userManagment/SignIn.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../utils/Regex/regex.dart';
import '../../utils/commonWidgets/CustomtextField.dart';
import '../../utils/commonWidgets/headerText.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xff0425BF),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 40, 0, 0),
                child: headerWidget(
                  title: findmyspot,
                  color: Colors.white, FontSize: 60,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 180),
                child: Image.asset(
                  SignUpCurve,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  fit: BoxFit.fill,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 1.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 220, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CreateAccountText(),
                    signUpFormWidget()],
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget CreateAccountText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          createAnAccount,
          style: TextStyle(
            fontSize: 25,
            color: SecondaryColor,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          signUpToContinue,
          style: TextStyle(
            fontSize: 15,
            color: LightGreyColor,
          ),
        ),
      ],
    );
  }

  Container signUpFormWidget() {
    final controller = Get.put(SignUpController());

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [

            CustomTextField(
              label: name,
              placeholder: tempName,
              icon:  Icons.person_outline_rounded,
              secureText: false,
              controller:  controller.fullname,
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
              label: email,
              placeholder: tempEmail,
              icon: Icons.email_outlined,
              secureText: false,
              controller: controller.email,
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
              label: phone,
              placeholder: tempPhone,
              icon: Icons.numbers,
              secureText: false,
              controller: controller.phoneNo,
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
              label: password,
              placeholder: '******',
              icon: Icons.password,
              secureText: true,
              controller: controller.password,
              type:  TextInputType.text,
              validator: (val) {
                if (controller.password.toString().isEmpty ) {
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
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignUpController.instance
                          .createUserWithEmailpassword(
                          controller.email.text.toString(),
                          controller.password.text.toString())
                          .then((value) {
                        final user = UserModel(
                          id: controller.getCurrentUserUid().toString(),
                          name: controller.fullname.text.trim(),
                          email: controller.email.text.trim(),
                          phone: controller.phoneNo.text.trim(),
                          password: controller.password.text.trim(),
                          profileImage: "profileImage",
                        );
                        SignUpController.instance.createUser(user);
                      });
                    }
                  },
                  child: Text(
                    Signup.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: SecondaryColor),
                ),

            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(SignIn());
              },
              child: Text(
                alreadyHaveAccount,
                style: TextStyle(
                  fontSize: 15,
                  color: LightGreyColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
