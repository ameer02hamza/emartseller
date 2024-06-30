import 'package:emartseller/const/const.dart';
import 'package:emartseller/controllers/products.controller.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

Widget productDropdown(
    {required title,
    required List<String> list,
    required dropValue,
    required ProductController controller}) {
  return Obx(
    () => DropdownButtonHideUnderline(
            child: DropdownButtonFormField(
      // validator: (value) {
      //   if (value == null) {
      //     return "Please select a category";
      //   }
      // },
      hint: generalText(text: title, color: fontGrey),
      value: dropValue.value == "" ? null : dropValue.value,
      items: list.map((e) {
        return DropdownMenuItem(
          value: e,
          child: generalText(text: e.toString(), color: fontGrey),
        );
      }).toList(),
      onChanged: (value) async {
        if (title.toString().toLowerCase().contains("category")) {
          controller.subCategoryValue.value = "";

          controller.populateSubCategoryList(value.toString());
        }
        dropValue.value = value;
      },
    ))
        .box
        .white
        .roundedSM
        .padding(const EdgeInsets.symmetric(horizontal: 5))
        .width(Get.context!.screenWidth - 20)
        .make(),
  );
}
// DropdownButtonFormField