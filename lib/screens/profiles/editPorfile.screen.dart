import 'dart:io';

import 'package:emartseller/const/const.dart';
import 'package:emartseller/const/images.dart';
import 'package:emartseller/controllers/profile.controller.dart';
import 'package:emartseller/widgets/customFormField.widget.dart';
import 'package:emartseller/widgets/loading.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreemState();
}

class _EditProfileScreemState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    controller.nameController.text = controller.snapshotData["vendor_name"];
    super.initState();
  }

  updateProfile(context) async {
    if (Get.find<ProfileController>().profileImgPath.value.isEmpty) {
      Get.find<ProfileController>().profileImageLink =
          controller.snapshotData['img_url'];
    }
    if (Get.find<ProfileController>().isChnagePaswd.value) {
      Get.find<ProfileController>().changePassword(
          email: controller.snapshotData['email'],
          oldPswd: Get.find<ProfileController>().oldPswdController.text,
          newPassword: Get.find<ProfileController>().pswdController.text,
          context: context);
      return;
    }
    await Get.find<ProfileController>().updateProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        title: boldText(text: "$edit Profile", size: 18),
        actions: [
          TextButton(
              onPressed: () {
                if (controller.isLoading.value) {
                  return;
                }
                updateProfile(context);
              },
              child: Obx(() => controller.isLoading.value
                  ? loadingIndicator(color: white)
                  : boldText(text: save, size: 18)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(
          () => Form(
            key: formKey,
            child: Column(
              children: [
                controller.profileImgPath.isEmpty &&
                        controller.snapshotData['img_url'] == ""
                    ? Image.asset(
                        imgProduct,
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : controller.snapshotData['img_url'] != "" &&
                            controller.profileImgPath.isEmpty
                        ? Image.network(
                            controller.snapshotData['img_url'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImgPath.value),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ElevatedButton(
                  onPressed: () {
                    controller.changeImage(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: generalText(text: "Change Image", color: primaryColor),
                ),
                const Divider(),
                customFormField(
                    hintText: nameHint,
                    title: name,
                    controller: controller.nameController),
                5.heightBox,
                5.heightBox,
                Row(
                  children: [
                    Checkbox(
                        checkColor: primaryColor,
                        fillColor: WidgetStateProperty.all(white),
                        side: const BorderSide(color: white),
                        value: controller.isChnagePaswd.value,
                        onChanged: (newValue) {
                          controller.isChnagePaswd(newValue);
                        }),
                    10.widthBox,
                    Expanded(
                        child: RichText(
                            text: TextSpan(children: [
                      TextSpan(
                          text: "Change Password".toUpperCase(),
                          style: const TextStyle(
                            color: white,
                          )),
                    ])))
                  ],
                ),
                if (controller.isChnagePaswd.value) ...[
                  10.heightBox,
                  customFormField(
                    hintText: passwordHint,
                    title: oldPassword,
                    isPswd: true,
                    controller: controller.oldPswdController,
                  ),
                  10.heightBox,
                  customFormField(
                    hintText: password,
                    title: password,
                    isPswd: true,
                    controller: controller.pswdController,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
