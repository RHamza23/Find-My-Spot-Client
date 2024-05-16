import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inpark/src/view/userManagment/SignUp.dart';
import '../../constants/colors.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../../controller/signUp_controller.dart';
import '../../utils/Regex/regex.dart';
import '../../utils/commonWidgets/CustomtextField.dart';
import '../Dashboard/dashboard.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  static SignUpController get instance => Get.find();
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());

  // show the password or not
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color(0xff0425BF),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
              child: SizedBox(
                height: 300,
                width: 300,
                child: Image.asset(bikeImage, color: Colors.white,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Image.asset(SignInCurve,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height / 1.6),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 400, 30, 0),
              child: Column(
                children: [
                CreateAccountText(),
                Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              label: email,
              placeholder: tempEmail,
              icon: Icons.email_outlined,
              secureText: false,
              controller: controller.email,
              type: TextInputType.emailAddress,
              validator: (val) {
                if (val!.isValidEmail == false) return 'Enter valid email';
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: password,
              placeholder: '******',
              icon: Icons.password,
              secureText: _isObscure,
              suffixIcon: IconButton(
                icon: _isObscure ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                onPressed: () {
                  print(_isObscure);
                  setState(() {
                    _isObscure = !_isObscure;
                    print(_isObscure);
                  });
                },
              ),
              controller: controller.password,
              type: TextInputType.text,
              validator: (val) {
                if (controller.password.toString().isEmpty) {
                  return 'Please enter some text';
                }
                if (val!.isValidPassword == false)
                  return ' Password should contain A,a ,123, @#*';
              },
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      SignUpController.instance
                          .LoginWithEmailpassword(controller.email.text.trim(),
                          controller.password.text.trim())
                          .then((value) => {
                        if (value == true)
                          {
                            Get.snackbar(
                                "Success", "Login Successfully",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: PrimaryColor,
                                colorText: Colors.black),
                            Get.to(Dashboard())
                          }
                        else
                          {
                            Get.snackbar(
                                "Failed", "User does not exist",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: PrimaryColor,
                                colorText: Colors.black)
                          }
                      });
                    }
                  },
                  child: Text(
                    Signin.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: SecondaryColor),
                )),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Get.to(SignUp());
              },
              child: Text(
                dontHaveAccount,
                style: TextStyle(
                  fontSize: 15,
                  color: LightGreyColor,
                ),
              ),
            ),
          ],
        ),
      ),
    )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CreateAccountText() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 100),
          child: Text(
            signInToAccount,
            style: TextStyle(
              fontSize: 25,
              color: SecondaryColor,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 160),
          child: Text(
            signInToContinue,
            style: TextStyle(
              fontSize: 15,
              color: LightGreyColor,
            ),
          ),
        ),
      ],
    );
  }
}
