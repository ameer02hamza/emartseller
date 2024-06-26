import 'package:emartseller/controllers/profile.controller.dart';
import 'package:emartseller/widgets/customFormField.widget.dart';
import 'package:emartseller/widgets/cutomTextArea.widget.dart';
import 'package:emartseller/widgets/loading.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class ShopSettingScreen extends StatelessWidget {
  const ShopSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    GlobalKey<FormState> formKey = GlobalKey();
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        title: boldText(text: shopSettings, size: 18),
        actions: [
          TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  controller.updateShopDetails(context);
                }
              },
              child: Obx(() => controller.isLoading.value
                  ? loadingIndicator(color: white)
                  : generalText(text: save, size: 18)))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                customFormField(
                    title: shopName,
                    hintText: shopNameHint,
                    controller: controller.shopNameController),
                10.heightBox,
                customFormField(
                    title: shopAddress,
                    hintText: shopAddressHint,
                    controller: controller.addressController),
                10.heightBox,
                customFormField(
                    title: shopMobile,
                    hintText: shopMobileHint,
                    controller: controller.phoneController),
                10.heightBox,
                customFormField(
                    title: shopWebHint,
                    hintText: shopWebHint,
                    controller: controller.webController),
                10.heightBox,
                customTextArea(
                    title: shopDesc,
                    hintText: shopDescHint,
                    controller: controller.descController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
