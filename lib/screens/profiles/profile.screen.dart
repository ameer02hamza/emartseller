import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartseller/const/images.dart';
import 'package:emartseller/controllers/auth.controller.dart';
import 'package:emartseller/controllers/profile.controller.dart';
import 'package:emartseller/screens/messages/messageList.screen.dart';
import 'package:emartseller/screens/profiles/editPorfile.screen.dart';
import 'package:emartseller/screens/settings/shopDetails.screen.dart';
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
        backgroundColor: primaryColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: generalSetting, size: 18, color: textfieldGrey),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => const EditProfileScreen());
                },
                icon: const Icon(
                  Icons.edit,
                  color: textfieldGrey,
                )),
            TextButton(
                onPressed: () {
                  authCtrl.logoutMethod(context: context);
                },
                child:
                    generalText(text: logout, size: 14, color: textfieldGrey))
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
                      text: "No Record Found", color: textfieldGrey, size: 20));
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
                  title:
                      boldText(text: data["vendor_name"], color: textfieldGrey),
                  subtitle:
                      generalText(text: data["email"], color: textfieldGrey),
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
                                        Get.to(() => const ShopDetailsScreen());
                                        break;
                                      case 1:
                                        Get.to(
                                            () => const MessagesListScreen());
                                        break;
                                      default:
                                    }
                                  },
                                  leading: Icon(settingIcons[index],
                                      color: textfieldGrey),
                                  title: boldText(
                                      text: settingList[index],
                                      color: textfieldGrey))
                              .box
                              .margin(const EdgeInsets.only(bottom: 10))
                              .make()),
                    )
                        .box
                        .outerShadow3Xl
                        .rounded
                        .color(primaryColor)
                        .padding(const EdgeInsets.all(10))
                        .make()),
              ],
            );
          },
        ));
  }
}
