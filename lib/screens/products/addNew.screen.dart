import 'package:emartseller/controllers/products.controller.dart';
import 'package:emartseller/screens/products/components/productDropDown.component.dart';
import 'package:emartseller/screens/products/components/productImage.component.dart';
import 'package:emartseller/widgets/customFormField.widget.dart';
import 'package:emartseller/widgets/customTextArea.widget.dart';
import 'package:emartseller/widgets/loading.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  var controller = Get.put(ProductController());
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    getScreenData();

    super.initState();
  }

  getScreenData() async {
    setState(() {
      isLoading = true;
    });
    await controller.getCategoryList();
    await controller.populateCategoryList();
    setState(() {
      isLoading = false;
    });
  }

  addNewProduct() async {
    if (controller.pImages.where((e) => e == null).toList().isNotEmpty) {
      controller.isLoading.value = false;
      VxToast.show(
        context,
        msg: "All Three Images are required",
        position: VxToastPosition.top,
        bgColor: red,
        textColor: textfieldGrey,
        showTime: 5000,
      );
      return;
    }
    if (formKey.currentState!.validate()) {
      controller.isLoading.value = true;
      if (controller.pImages.isNotEmpty) {
        await controller.uploadImages();
      }
      await controller.uploadProduct(context);
      controller.isLoading.value = false;
      formKey.currentState!.reset();
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: textfieldGrey),
        title: boldText(text: "Add New Product", color: textfieldGrey),
        actions: [
          Obx(
            () => controller.isLoading.value
                ? Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: loadingIndicator(color: textfieldGrey))
                : TextButton(
                    onPressed: addNewProduct,
                    child: generalText(text: "Save", color: textfieldGrey)),
          )
        ],
      ),
      body: isLoading
          ? Center(child: loadingIndicator(color: textfieldGrey))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customFormField(
                          title: "Name",
                          hintText: "e.g Apple",
                          controller: controller.pNameController),
                      10.heightBox,
                      customFormField(
                          title: "Price",
                          hintText: "e.g \$200",
                          controller: controller.pPriceController,
                          isNumeric: true),
                      10.heightBox,
                      customFormField(
                          title: "Quantity",
                          hintText: "e.g 20",
                          controller: controller.pQuantityController,
                          isNumeric: true),
                      10.heightBox,
                      customTextArea(
                          title: "Description",
                          hintText: "e.g Fresh Apple from the farm",
                          controller: controller.pDescController),
                      10.heightBox,
                      productDropdown(
                          title: "Category",
                          dropValue: controller.categoryValue,
                          list: controller.catList,
                          controller: controller),
                      10.heightBox,
                      productDropdown(
                          title: "Choose subcat",
                          dropValue: controller.subCategoryValue,
                          list: controller.subCatList,
                          controller: controller),
                      const Divider(),
                      generalText(
                          text: "Choose Product Images",
                          color: textfieldGrey,
                          size: 18),
                      5.heightBox,
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              3,
                              (index) => controller.pImages[index] != null
                                  ? Image.file(controller.pImages[index],
                                          fit: BoxFit.cover)
                                      .box
                                      // .color(textfieldGrey)
                                      .size(100, 100)
                                      .clip(Clip.hardEdge)
                                      .roundedSM
                                      .make()
                                      .onTap(() {
                                      controller.pickProductImage(
                                          index, context);
                                    })
                                  : productImages(
                                          label: "Image ${index + 1}",
                                          onPress: () {})
                                      .onTap(() {
                                      controller.pickProductImage(
                                          index, context);
                                    })),
                        ),
                      ),
                      5.heightBox,
                      generalText(
                          text: "Thumbnail will be the first Image",
                          color: textfieldGrey,
                          size: 12),
                      const Divider(),
                      generalText(
                          text: "Choose Product Colors",
                          color: textfieldGrey,
                          size: 18),
                      5.heightBox,
                      Obx(
                        () => Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children: List.generate(
                              14,
                              (index) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      VxBox()
                                          .color(Vx.randomPrimaryColor)
                                          .roundedFull
                                          .size(50, 50)
                                          .make(),
                                      Visibility(
                                          visible: controller.selectedColorIndex
                                                      .value ==
                                                  index
                                              ? true
                                              : false,
                                          child: const Icon(
                                            Icons.check,
                                            color: textfieldGrey,
                                          ))
                                    ],
                                  ).onTap(() {
                                    setState(() {
                                      controller.selectedColorIndex.value =
                                          index;
                                    });
                                  })),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
