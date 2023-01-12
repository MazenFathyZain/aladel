import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_karim/view/auth_view/register.dart';

import '../../constants.dart';
import '../../services/auth.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/custom_text.dart';
import '../custom_widgets/custom_text_form_field.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Auth controller = Get.put(Auth());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only( top: 50,left: 20, right: 20,),
            child: Column(
              children: [
                Image.asset(
                  "assets/last.jpeg",
                  scale: 1,
                  // width: width ,
                  // height: height * 40 / 100,
                  fit: BoxFit.contain,
                ),
                loginForm(width, height),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm(double width, double height) {
    return Container(
      color: Colors.white,
      width: width,
      height: height * 50 /100,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              onSave: (value) {
                controller.email = value;
              },
              validator: (value) {
                if (value == null) {
                  print("Error");
                }
              },
              text: "البريد الإلكتروني",
              hint: "أدخل بريدك الإلكتروني",
            ),
            SizedBox(
              height: height * 4 / 100,
            ),
            CustomTextFormField(
              text: "كلمة السر",
              hint: "أدخل كلمة السر",
              obscureText: true,
              onSave: (value) {
                controller.password = value;
              },
              validator: (value) {
                if (value == null) {
                  print("Error");
                }
              },
            ),
            SizedBox(
              height: height * 4 / 100,
            ),
            Container(
              padding: const EdgeInsets.only(top: 2.0),
              width: width,
              child: CustomButton(
                text: "تسجيل الدخول",
                onpressed: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    controller.login();
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(""),
                TextButton(
                  onPressed: () {
                    Get.to(Register());
                  },
                  child: CustomText(
                    text: "انشاء حساب؟",
                    fontsize: 13,
                    fontwight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
