import 'package:emartseller/const/const.dart';
import 'package:emartseller/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var pNameController = new TextEditingController();
  var pPriceController = new TextEditingController();
  var pQuantityController = new TextEditingController();
  var pDescController = new TextEditingController();
  var catList = <String>[].obs;
  var subCatList = <String>[].obs;
  List<Category> categoryList = [];
  var pImages = [].obs;
  var categoryValue = "".obs;
  var subCategoryValue = "".obs;
  var selectedColorIndex = 0.obs;

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

  pickProductImage() async {}
}
