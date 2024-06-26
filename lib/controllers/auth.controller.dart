import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartseller/const/const.dart';
import 'package:emartseller/const/firebase.const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCred;
    isLoading(true);
    try {
      userCred = await firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text.toString().trim(),
          password: passwordController.text);
      isLoading(false);
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      VxToast.show(
        context,
        msg: e.message.toString().split(",")[0].toString(),
        position: VxToastPosition.top,
        bgColor: Vx.red800,
        textColor: white,
        showTime: 5000,
      );
    }
    return userCred;
  }

  Future<UserCredential?> signupMethod({name, email, password, context}) async {
    UserCredential? userCred;
    try {
      userCred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(
        context,
        msg: e.message.toString(),
        position: VxToastPosition.top,
        bgColor: Vx.red800,
        textColor: white,
        showTime: 5000,
      );
    }
    return userCred;
  }

  Future<void> logoutMethod({context}) async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  Future<dynamic> storeUserData({name, email}) async {
    try {
      DocumentReference store =
          firebaseStore.collection(usersCollections).doc(currentUser!.uid);
      store.set({
        "name": name,
        // "password": password,
        "email": email,
        "profileUrl": "",
        "id": currentUser!.uid,
        "cartCount": "00",
        "orderCount": "00",
        "wishListCount": "00",
      });
    } catch (e) {
      print("error in storeUserData: $e");
    }
  }
}
