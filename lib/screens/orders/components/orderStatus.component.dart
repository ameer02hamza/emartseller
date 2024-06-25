import 'package:get/get.dart';

import '../../../const/const.dart';

Widget orderStatus({icon, title, color, showDone}) {
  return ListTile(
      leading: Icon(icon, color: color).box.border(color: primaryColor).make(),
      trailing: SizedBox(
          width: Get.context!.screenWidth / 3.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              title.toString().text.size(14).make(),
              if (showDone)
                const Icon(Icons.done, color: primaryColor, size: 20)
            ],
          )));
}
