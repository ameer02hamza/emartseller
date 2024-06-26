import 'dart:ui';

import 'package:emartseller/const/const.dart';
import 'package:emartseller/const/images.dart';
import 'package:emartseller/controllers/auth.controller.dart';
import 'package:emartseller/screens/home/home.dart';
import 'package:emartseller/widgets/authFormField.widget.dart';
import 'package:emartseller/widgets/customButton.widget.dart';
import 'package:emartseller/widgets/loading.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    loginUser() async {
      if (formKey.currentState!.validate()) {
        controller.loginMethod(context: context).then((value) {
          print("User: $value");
          if (value != null) {
            Get.to(() => const Home());
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: false,
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
            (context.screenHeight * 0.09).heightBox,
            SingleChildScrollView(
                    child: Form(
                        key: formKey,
                        child: Obx(() => Column(
                              children: [
                                authFormField(
                                  hintText: emailHint,
                                  title: email,
                                  icon: Icons.email,
                                  controller: controller.emailController,
                                ),
                                15.heightBox,
                                authFormField(
                                  hintText: passwordHint,
                                  title: password,
                                  icon: Icons.lock,
                                  isPswd: true,
                                  controller: controller.passwordController,
                                ),
                                10.heightBox,
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: generalText(
                                      text: "$forgotPassword?",
                                      color: primaryColor),
                                ),
                                10.heightBox,
                                SizedBox(
                                    width: context.screenWidth - 50,
                                    child: controller.isLoading.value
                                        ? Center(child: loadingIndicator())
                                        : customButton(
                                            title: login,
                                            onPressed: loginUser,
                                            bgColor: primaryColor,
                                            textColor: white,
                                          )),
                              ],
                            ))))
                .box
                .white
                .outerShadow3Xl
                .rounded
                .padding(const EdgeInsets.all(8))
                .make(),
            Center(
              child: generalText(text: anyProblem, color: lightGrey, size: 14),
            ),
            const Spacer(),
            Center(child: boldText(text: credit))
          ],
        ),
      )),
    );
  }
}
