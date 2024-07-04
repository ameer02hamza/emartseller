import 'package:emartseller/const/const.dart';
import 'package:emartseller/controllers/profile.controller.dart';
import 'package:emartseller/screens/settings/editShopSetting.screen.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

Widget detailsCard({required context, required int index, required width}) {
  var profileCtrl = Get.find<ProfileController>();
  return Stack(children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
                visible: profileCtrl.shopSnapData[index]['is_primary'],
                child: const Icon(
                  Icons.check_circle,
                  color: successColor,
                  size: 20,
                )),
            Row(
              children: [
                Visibility(
                  visible: profileCtrl.shopSnapData[index]['is_verified'],
                  child: const Badge(
                    backgroundColor: successColor,
                    textColor: white,
                    label: Text("Verified"),
                  ),
                ),
                VxPopupMenu(
                  controller: profileCtrl.vxCtrl,
                  clickType: VxClickType.singleClick,
                  showArrow: false,
                  menuBuilder: () {
                    return Column(
                      children: List.generate(shopPopMenu.length, (i) {
                        return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(children: [
                              Icon(
                                shopPopMenuIcons[i],
                                color: textfieldGrey,
                              ),
                              5.widthBox,
                              generalText(
                                text: shopPopMenu[i],
                                color: textfieldGrey,
                              )
                            ])).onTap(
                          () async {
                            profileCtrl.vxCtrl.hideMenu();
                            switch (i) {
                              case 0:
                                Get.to(() => EditShopSettingScreen(
                                      shopData: profileCtrl.shopSnapData[index],
                                    ));
                                break;
                              case 1:
                                if (profileCtrl.shopSnapData[index]
                                    ['is_primary']) {
                                  VxToast.show(
                                    context,
                                    msg: "You can't delete primary shop",
                                    position: VxToastPosition.top,
                                    bgColor: Vx.red800,
                                    textColor: white,
                                    showTime: 5000,
                                  );
                                  return;
                                }
                                VxDialog.showConfirmation(
                                  context,
                                  title: "Delete Shop",
                                  content:
                                      "Are you sure you want to delete this $name?",
                                  confirm: "Yes",
                                  cancel: "No",
                                  onConfirmPress: () async {
                                    await profileCtrl.deleteShopDetails(context,
                                        profileCtrl.shopSnapData[index].id);
                                  },
                                );
                                break;
                              case 2:
                                if (profileCtrl.shopSnapData[index]
                                    ['is_primary']) {
                                  return;
                                }
                                await profileCtrl.updatePrimaryAddress(
                                    profileCtrl.shopSnapData[index].id);
                                break;
                              default:
                            }
                          },
                        );
                      }),
                    )
                        .box
                        .width(200)
                        .rounded
                        .padding(const EdgeInsets.all(10))
                        .white
                        .make();
                    ;
                  },
                  child: const Icon(
                    Icons.more_vert,
                    color: textfieldGrey,
                  ),
                )
              ],
            ),
          ],
        ),
        semiBoldText(
            text: profileCtrl.shopSnapData[index]['shop_name'],
            size: 14,
            color: textfieldGrey),
        generalText(
            text: profileCtrl.shopSnapData[index]['phone'].toString(),
            size: 14,
            color: textfieldGrey),
        linkText(
            text: profileCtrl.shopSnapData[index]['web'],
            size: 14,
            color: linkColor),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            semiBoldText(text: 'Address:', size: 14, color: textfieldGrey),
            SizedBox(
                width: width,
                child: generalText(
                    text: profileCtrl.shopSnapData[index]['address'].toString(),
                    size: 14,
                    color: textfieldGrey))
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            semiBoldText(text: 'Description:', size: 14, color: textfieldGrey),
            SizedBox(
                width: width,
                child: generalText(
                    text: profileCtrl.shopSnapData[index]['description'],
                    size: 14,
                    color: textfieldGrey))
          ],
        ),
      ],
    ),
  ])
      .box
      .outerShadowMd
      .padding(const EdgeInsets.only(bottom: 10, left: 10))
      .margin(const EdgeInsets.only(bottom: 10))
      .color(primaryColor)
      .border(
          color: profileCtrl.shopSnapData[index]['is_primary']
              ? white
              : Colors.transparent,
          width: profileCtrl.shopSnapData[index]['is_primary'] ? 1 : 0)
      .rounded
      .make();
}
