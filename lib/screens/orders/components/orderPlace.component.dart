import 'package:emartseller/const/const.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

///@params title1=title of the first column, title2=title of the second column,
/// d1=data of the first column, d2=data of the second column
Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title1.toString().text.bold.color(textfieldGrey).make(),
              boldText(text: d1, color: primaryColor)
            ],
          ),
          SizedBox(
              width: Get.context!.screenWidth / 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title2.toString().text.bold.color(textfieldGrey).make(),
                  boldText(text: d2, color: primaryColor),
                ],
              )),
        ],
      ));
}
