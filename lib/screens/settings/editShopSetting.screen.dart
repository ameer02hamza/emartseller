import 'package:emartseller/const/const.dart';
import 'package:emartseller/controllers/profile.controller.dart';
import 'package:emartseller/widgets/customFormField.widget.dart';
import 'package:emartseller/widgets/customTextArea.widget.dart';
import 'package:emartseller/widgets/loading.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

class EditShopSettingScreen extends StatefulWidget {
  var shopData;
  EditShopSettingScreen({super.key, required this.shopData});

  @override
  State<EditShopSettingScreen> createState() => _EditShopSettingScreenState();
}

class _EditShopSettingScreenState extends State<EditShopSettingScreen> {
  var controller = Get.find<ProfileController>();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    controller.shopNameController.text = widget.shopData['shop_name'];
    controller.addressController.text = widget.shopData['address'];
    controller.phoneController.text = widget.shopData['phone'];
    controller.webController.text = widget.shopData['web'];
    controller.descController.text = widget.shopData['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        title: boldText(text: shopSettings, size: 18),
        actions: [
          TextButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await controller.updateShopDetails(
                      context, widget.shopData.id);
                  formKey.currentState!.reset();
                  Get.back();
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
                    controller: controller.phoneController,
                    isNumeric: true),
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
