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
            boldText(text: title, size: 16),
            boldText(text: count, size: 20),
          ],
        ),
      ),
      Image.asset(
        icon,
        width: 40,
        color: white,
      )
    ],
  )
      .box
      .color(primaryColor)
      .rounded
      .size(Get.context!.screenWidth * 0.4, 80)
      .padding(const EdgeInsets.all(8))
      .make();
}
