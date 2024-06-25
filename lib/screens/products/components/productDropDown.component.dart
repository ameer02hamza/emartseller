import 'package:emartseller/const/const.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

Widget productDropdown({required title}) {
  return DropdownButtonHideUnderline(
          child: DropdownButton(
    hint: generalText(text: title, color: fontGrey),
    value: null,
    items: [],
    onChanged: (value) {},
  ))
      .box
      .white
      .roundedSM
      .padding(const EdgeInsets.symmetric(horizontal: 5))
      .width(Get.context!.screenWidth - 20)
      .make();
}
// 