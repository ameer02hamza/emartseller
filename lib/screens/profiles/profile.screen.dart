import 'package:emartseller/const/images.dart';
import 'package:emartseller/screens/messages/messageList.screen.dart';
import 'package:emartseller/screens/profiles/editPorfile.screen.dart';
import 'package:emartseller/screens/settings/shopsetting.screen.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: generalSetting, size: 18),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const EditProfile());
              },
              icon: const Icon(
                Icons.edit,
                color: white,
              )),
          TextButton(
              onPressed: () {}, child: generalText(text: logout, size: 14))
        ],
      ),
      body: Column(
        children: [
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onTap: () {},
            leading: Image.asset(imgProduct)
                .box
                .roundedFull
                .clip(Clip.antiAlias)
                .make(),
            title: boldText(text: "Vendor Name", color: white),
            subtitle: generalText(text: "ameer02hamza@gmail.com", color: white),
          ),
          const Divider(),
          10.heightBox,
          Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: List.generate(
                    settingList.length,
                    (index) => ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onTap: () {
                          print("%c $index");
                          switch (index) {
                            case 0:
                              Get.to(() => const ShopSettingScreen());
                              break;
                            case 1:
                                 Get.to(() => const MessagesListScreen());
                              break;
                            default:
                          }
                        },
                        leading: Icon(settingIcons[index], color: white),
                        title:
                            boldText(text: settingList[index], color: white))),
              )),
        ],
      ),
    );
  }
}
