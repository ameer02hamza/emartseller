import 'package:emartseller/const/const.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

import '../const/images.dart';

Widget dashboardButton({required title, required count, required icon}) {
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            boldText(text: title, size: 14, color: textfieldGrey),
            boldText(text: count, size: 12, color: textfieldGrey),
          ],
        ),
      ),
      Image.asset(
        icon,
        width: 40,
        color: textfieldGrey,
      )
    ],
  )
      .box
      .color(lightPrimary.withOpacity(0.8))
      .rounded
      .size(Get.context!.screenWidth * 0.4, 80)
      .padding(const EdgeInsets.all(8))
      .make();
}
