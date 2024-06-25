import 'dart:ui';

import 'package:emartseller/const/const.dart';
import 'package:emartseller/const/images.dart';
import 'package:emartseller/screens/home/home.dart';
import 'package:emartseller/widgets/authFormField.widget.dart';
import 'package:emartseller/widgets/customButton.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            generalText(
              text: welcome,
              size: 18,
            ),
            Row(
              children: [
                Image.asset(
                  icLogo,
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain,
                )
                    .box
                    .border(color: white)
                    .rounded
                    .padding(const EdgeInsets.all(8))
                    .make(),
                10.widthBox,
                boldText(
                  text: appname,
                  color: white,
                  size: 20,
                )
              ],
            ),
            30.heightBox,
            SingleChildScrollView(
                    child: Form(
                        child: Column(
              children: [
                authFormField(
                  hintText: emailHint,
                  title: email,
                  icon: Icons.email,
                ),
                15.heightBox,
                authFormField(
                  hintText: passwordHint,
                  title: password,
                  icon: Icons.lock,
                  isPswd: true,
                ),
                10.heightBox,
                Align(
                  alignment: Alignment.centerRight,
                  child: generalText(
                    text: "$forgotPassword?",
                    color: primaryColor
                  ),
                ),
                10.heightBox,
                SizedBox(
                    width: context.screenWidth - 50,
                    child: customButton(
                      title: login,
                      onPressed: () {
                        Get.to(()=> Home());
                      },
                      bgColor: primaryColor,
                      textColor: white,
                    )),
              ],
            )))
                .box
                .white
                .outerShadowMd
                .rounded
                .padding(const EdgeInsets.all(8))
                .make(),
            Center(
              child: generalText(
                text: anyProblem,
                color: lightGrey
              ),
            ),
            const Spacer(),
            Center(child: boldText(text: credit))
          ],
        ),
      )),
    );
  }
}
