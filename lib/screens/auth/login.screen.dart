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
      backgroundColor: primaryColor,//.withOpacity(0.5),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(
              height: context.screenHeight / 2.5,
              width: double.infinity,
              child: Image.asset(imgLogin),
            ),
            // semiBoldText(text: welcome, size: 14, color: white),
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
                                  color: textfieldGrey),
                            ),
                            10.heightBox,
                            SizedBox(
                                width: context.screenWidth - 50,
                                child: controller.isLoading.value
                                    ? Center(child: loadingIndicator(color: textfieldGrey))
                                    : customButton(
                                        title: login,
                                        onPressed: loginUser,
                                        bgColor: lightPrimary,
                                        textColor: textfieldGrey,
                                      )),
                                        Center(
              child: generalText(text: anyProblem, color: lightGrey, size: 14),
            ),
                          ],
                        )
                            .box
                            .rounded
                            .outerShadow3Xl
                            .color(primaryColor)
                            .padding(const EdgeInsets.all(15))
                            .make()))),
          
            const Spacer(),
            Center(child: boldText(text: credit))
          ],
        ),
      )),
    );
  }
}
