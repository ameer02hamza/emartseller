import 'package:emartseller/const/const.dart';
import 'package:intl/intl.dart' as intl;

Widget chatBubble(msg, isSender) {
  return Directionality(
      textDirection: isSender ? TextDirection.ltr : TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isSender ? darkGrey : fontGrey,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: isSender
                  ? const Radius.circular(20)
                  : const Radius.circular(0),
              bottomRight: !isSender
                  ? const Radius.circular(20)
                  : const Radius.circular(0),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            msg.toString().text.white.size(16).make(),
            10.heightBox,
            intl.DateFormat.jm()
                .format(DateTime.now())
                .toString()
                .text
                .white
                .size(16)
                .make()
          ],
        ),
      ));
}
