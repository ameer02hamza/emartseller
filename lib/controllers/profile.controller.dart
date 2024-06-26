import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartseller/const/firebase.const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../const/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var nameController = TextEditingController();
  var shopNameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var webController = TextEditingController();
  var pswdController = TextEditingController();
  var descController = TextEditingController();
  var oldPswdController = TextEditingController();
  var isLoading = false.obs;
  var isChnagePaswd = false.obs;
  var profileImgPath = ''.obs;
  var profileImageLink = '';
  var snapshotData;
  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (img == null) return;
      print("%c ${img.path}");
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      print(" %c error: $e");
      VxToast.show(context, msg: e.message.toString());
    }
  }

  uploadProfileImage() async {
    try {
      var fileName = basename(profileImgPath.value);
      var destination = 'profile/${currentUser!.uid}/$fileName';
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(File(profileImgPath.value));
      profileImageLink = await ref.getDownloadURL();
    } catch (e) {
      print(" %c error: $e");
    }
  }

  updateProfile(context) async {
    try {
      print(snapshotData);
      isLoading(true);
      if (profileImgPath.value.isNotEmpty) {
        await uploadProfileImage();
      }
      await firebaseStore
          .collection(vendorCollections)
          .doc(snapshotData.id)
          .update({
        "vendor_name": nameController.text,
        "img_url": profileImageLink,
      });
      isLoading(false);
      oldPswdController.text = "";
      pswdController.text = "";
      VxToast.show(
        context,
        msg: "Profile Updated successfully",
        position: VxToastPosition.top,
        bgColor: Vx.green600,
        textColor: white,
        showTime: 5000,
      );
    } catch (e) {
      // nameController.text = "";
      oldPswdController.text = "";
      pswdController.text = "";
      isLoading(false);
      VxToast.show(
        context,
        msg: "Error in updating profile, Try again",
        position: VxToastPosition.top,
        bgColor: Vx.red800,
        textColor: white,
        showTime: 5000,
      );
      print(" %c error: $e");
    }
  }

  changePassword({email, oldPswd, newPassword, context}) async {
    isLoading(true);
    final cred = EmailAuthProvider.credential(email: email, password: oldPswd);
    await currentUser!.reauthenticateWithCredential(cred).then((value) async {
      print("%c reauthenticated $value");
      await currentUser!.updatePassword(newPassword);
      await updateProfile(context);
      await firebaseAuth.signOut();
    }).catchError((error) {
      print(" %c error: ${error.message}");
      VxToast.show(
        context,
        msg: error.message,
        position: VxToastPosition.top,
        bgColor: Vx.red800,
        textColor: white,
        showTime: 5000,
      );
    });
  }

  updateShopDetails(context) async {
    isLoading(true);
    try {
      var store =
          firebaseStore.collection(vendorCollections).doc(currentUser!.uid);
      await store.set({
        "shop_name": shopNameController.text,
        "address": addressController.text,
        "phone": phoneController.text,
        "web": webController.text,
        "description": descController.text,
      }, SetOptions(merge: true));
      isLoading(false);
      VxToast.show(
        context,
        msg: "Updated Sucessfully",
        position: VxToastPosition.top,
        bgColor: successColor,
        textColor: white,
        showTime: 5000,
      );
    } catch (e) {
      isLoading(false);
      VxToast.show(
        context,
        msg: "Error in updating shop details",
        position: VxToastPosition.top,
        bgColor: Vx.red800,
        textColor: white,
        showTime: 5000,
      );
    }
  }
}
