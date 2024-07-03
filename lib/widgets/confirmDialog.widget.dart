import 'package:emartseller/const/const.dart';
import 'package:emartseller/controllers/profile.controller.dart';
import 'package:emartseller/widgets/customButton.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

Widget showDialogWidget({required BuildContext context, title, msg, docId}) {
  return Dialog(
    backgroundColor: Colors.amber,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        boldText(text: title, size: 20),
        const Divider(),
        10.heightBox,
        boldText(text: msg, size: 16),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customButton(
              bgColor: primaryColor,
              title: "Yes",
              onPressed: () {
                Get.find<ProfileController>().deleteShopDetails(context, docId);
                // Get.back();
              },
              textColor: white,
            ).box.roundedSM.make(),
            10.widthBox,
            customButton(
              bgColor: primaryColor,
              title: "NO",
              onPressed: () {
                Navigator.pop(context);
              },
              textColor: white,
            ).box.roundedSM.make(),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(15)).roundedSM.make(),
  );
}
