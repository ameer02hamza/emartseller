import 'package:emartseller/const/images.dart';
import 'package:emartseller/screens/messages/chat.screen.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class MessagesListScreen extends StatelessWidget {
  const MessagesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: boldText(text: messages, size: 16, color: white),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(20, (index) {
                return ListTile(
                  tileColor: primaryColor.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onTap: () {
                    Get.to(() => const ChatScreen());
                  },
                  leading: Image.asset(imgProduct)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make(),
                  title: boldText(text: "Vendor Name", color: white),
                  subtitle: generalText(
                      text: "last message...", color: textfieldGrey),
                  trailing: generalText(text: "12:00 PM", color: textfieldGrey),
                )
                    .box
                    .withDecoration(BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: textfieldGrey.withOpacity(0.3),
                                width: 0.5))))
                    .make();
              })),
        ));
  }
}
