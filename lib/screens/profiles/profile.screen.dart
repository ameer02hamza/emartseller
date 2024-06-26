import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartseller/const/images.dart';
import 'package:emartseller/controllers/auth.controller.dart';
import 'package:emartseller/controllers/profile.controller.dart';
import 'package:emartseller/screens/messages/messageList.screen.dart';
import 'package:emartseller/screens/profiles/editPorfile.screen.dart';
import 'package:emartseller/screens/settings/shopsetting.screen.dart';
import 'package:emartseller/services/store.service.dart';
import 'package:emartseller/widgets/loading.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var authCtrl = Get.put(AuthController());
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: generalSetting, size: 18, color: fontGrey),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const EditProfileScreen());
                },
                icon: const Icon(
                  Icons.edit,
                  color: fontGrey,
                )),
            TextButton(
                onPressed: () {
                  authCtrl.logoutMethod(context: context);
                },
                child: generalText(text: logout, size: 14, color: fontGrey))
          ],
        ),
        body: FutureBuilder(
          future: StoreService.getProfile(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: boldText(
                      text: "No Record Found", color: primaryColor, size: 20));
            }
            var data = snapshot.data!.docs.first;
            controller.snapshotData = data;
            return Column(
              children: [
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onTap: () {},
                  leading: data["img_url"] == ""
                      ? Image.asset(imgProduct)
                      : Image.network(data["img_url"])
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),
                  title: boldText(text: data["vendor_name"], color: fontGrey),
                  subtitle: generalText(text: data["email"], color: fontGrey),
                ),
                const Divider(),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: List.generate(
                          settingList.length,
                          (index) => ListTile(
                                  // tileColor: primaryColor.withOpacity(0.2),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => const ShopSettingScreen());
                                        break;
                                      case 1:
                                        Get.to(
                                            () => const MessagesListScreen());
                                        break;
                                      default:
                                    }
                                  },
                                  leading: Icon(settingIcons[index],
                                      color: fontGrey),
                                  title: boldText(
                                      text: settingList[index],
                                      color: fontGrey))
                              .box
                              .margin(const EdgeInsets.only(bottom: 10))
                              .make()),
                    )
                        .box
                        .outerShadow3Xl
                        .rounded
                        .white
                        .padding(const EdgeInsets.all(10))
                        .make()),
              ],
            );
          },
        ));
  }
}
