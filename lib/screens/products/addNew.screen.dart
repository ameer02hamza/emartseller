import 'package:emartseller/controllers/products.controller.dart';
import 'package:emartseller/screens/products/components/productDropDown.component.dart';
import 'package:emartseller/screens/products/components/productImage.component.dart';
import 'package:emartseller/widgets/customFormField.widget.dart';
import 'package:emartseller/widgets/cutomTextArea.widget.dart';
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

  @override
  void initState() {
    // TODO: implement initState
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        title: boldText(text: "Add New Product", color: white),
        actions: [
          TextButton(
              onPressed: () {}, child: generalText(text: "Save", color: white))
        ],
      ),
      body: isLoading
          ? Center(child: loadingIndicator(color: white))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
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
                        controller: controller.pPriceController),
                    10.heightBox,
                    customFormField(
                        title: "Quantity",
                        hintText: "e.g 20",
                        controller: controller.pQuantityController),
                    10.heightBox,
                    customTextArea(
                        title: "Description",
                        hintText: "e.g 20",
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
                        color: lightGrey,
                        size: 18),
                    5.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          3,
                          (index) => productImages(
                              label: "Image ${index + 1}", onPress: () {})),
                    ),
                    5.heightBox,
                    generalText(
                        text: "Thumbnail will be the first Image",
                        color: lightGrey,
                        size: 12),
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
                                        visible: controller
                                                    .selectedColorIndex.value ==
                                                index
                                            ? true
                                            : false,
                                        child: const Icon(
                                          Icons.check,
                                          color: white,
                                        ))
                                  ],
                                ).onTap(() {
                                  setState(() {
                                    controller.selectedColorIndex.value = index;
                                  });
                                })),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
