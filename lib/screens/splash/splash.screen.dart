import 'package:emartseller/const/colors.dart';
import 'package:emartseller/const/const.dart';
import 'package:emartseller/const/firebase.const.dart';
import 'package:emartseller/const/strings.dart';
import 'package:emartseller/screens/auth/login.screen.dart';
import 'package:emartseller/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAll(() => const LoginScreen());
      } else {
        Get.offAll(() => const Home());
      }
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
                alignment: Alignment.topCenter,
                child: Icon(
                  Icons.shop,
                  color: white,
                )
                //  Image.asset(
                //   icSplashBg,
                //   width: 300,
                // ),
                ),
            appname.text.bold.size(20).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            Align(
                alignment: Alignment.bottomCenter,
                child: credit.text.white.make()),
          ],
        ),
      ),
    );
  }
}
