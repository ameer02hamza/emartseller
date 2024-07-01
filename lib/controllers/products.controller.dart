import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartseller/const/const.dart';
import 'package:emartseller/const/firebase.const.dart';
import 'package:emartseller/controllers/home.controller.dart';
import 'package:emartseller/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductController extends GetxController {
  var pNameController = new TextEditingController();
  var pPriceController = new TextEditingController();
  var pQuantityController = new TextEditingController();
  var pDescController = new TextEditingController();
  var catList = <String>[].obs;
  var subCatList = <String>[].obs;
  List<Category> categoryList = [];
  var pImagesLink = [];
  var pImages = RxList<dynamic>.generate(3, (index) => null);
  var categoryValue = "".obs;
  var subCategoryValue = "".obs;
  var selectedColorIndex = 0.obs;
  var isLoading = false.obs;

  getCategoryList() async {
    try {
      var data =
          await rootBundle.loadString("lib/services/category_model.json");
      var cat = categoryModelFromJson(data);
      categoryList = cat.categories;
    } catch (e) {}
  }

  populateCategoryList() async {
    catList.clear();
    for (var item in categoryList) {
      catList.add(item.name);
    }
  }

  populateSubCategoryList(value) async {
    subCatList.clear();
    var data = categoryList.where((element) => element.name == value).toList();

    for (int i = 0; i < data.first.subcategory.length; i++) {
      subCatList.add(data.first.subcategory[i]);
    }
  }

  pickProductImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      }
      pImages[index] = File(img.path);
    } catch (e) {
      VxToast.show(context, msg: "Error picking image");
    }
  }

  uploadImages() async {
    pImagesLink.clear();
    try {
      for (var item in pImages) {
        if (item != null) {
          await uploadProductImage(item);
        }
      }
    } catch (e) {
      print(" %c error: $e");
    }
  }

  uploadProductImage(imagePath) async {
    try {
      var fileName = basename(imagePath.path);
      var destination = 'vendor/${currentUser!.uid}/products/$fileName';
      Reference ref = FirebaseStorage.instance.ref().child(destination);
      await ref.putFile(File(imagePath.path));
      var link = await ref.getDownloadURL();
      pImagesLink.add(link);
    } catch (e) {
      print(e);
      //  VxToast.show(context, msg: "Error picking image");
    }
  }

  uploadProduct(context) async {
    try {
      isLoading(true);
      var store = firebaseStore.collection(productCollections).doc();
      await store.set({
        "is_featured": false,
        "p_category": categoryValue.value,
        "p_desc": pDescController.text,
        "p_name": pNameController.text,
        "p_price": pPriceController.text,
        "p_quantity": pQuantityController.text,
        "p_rating": "0",
        "p_seller": Get.find<HomeController>().userName.value,
        "p_subcat": subCategoryValue.value,
        "vendor_id": currentUser!.uid,
        "p_colors": FieldValue.arrayUnion(
            [Colors.amber.value, Colors.green.value, Colors.red.value]),
        "p_imgs": FieldValue.arrayUnion(pImagesLink),
        "p_wishlist": FieldValue.arrayUnion([]),
        "featured_id": currentUser!.uid
      });
      isLoading(false);
    } catch (e) {
      isLoading(false);
      VxToast.show(
        context,
        msg: "Error in adding product, Try again",
        position: VxToastPosition.top,
        bgColor: red,
        textColor: white,
        showTime: 5000,
      );
    }
  }

  addRemoveFeature(docId, isFeatured) async {
    await firebaseStore.collection(productCollections).doc(docId).set(
        {"is_featured": !isFeatured, "featured_id": currentUser!.uid},
        SetOptions(merge: true));
  }

  removeProduct(docId) async {
    await firebaseStore.collection(productCollections).doc(docId).delete();
  }
}
