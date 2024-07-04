import 'package:emartseller/const/images.dart';
import 'package:emartseller/controllers/products.controller.dart';
import 'package:emartseller/screens/products/addNew.screen.dart';
import 'package:emartseller/screens/products/editProduct.screen.dart';
import 'package:emartseller/screens/products/productDetails.screen.dart';
import 'package:emartseller/services/store.service.dart';
import 'package:emartseller/widgets/appbar.widget.dart';
import 'package:emartseller/widgets/loading.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class PorductScreen extends StatelessWidget {
  const PorductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    var popCtrl = VxPopupMenuController();
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBarWidget(title: products),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
              stream: StoreService.getProductsByVendor(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: loadingIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: boldText(text: "No Products found", color: textfieldGrey),
                  );
                }
                var data = snapshot.data.docs;
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(data.length, (index) {
                        return ListTile(
                          tileColor: lightPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onTap: () {
                            Get.to(() =>
                                ProductDetailsScreen(productData: data[index]));
                          },
                          leading: Image.network(data[index]['p_imgs'].first)
                              .box
                              .roundedSM
                              .clip(Clip.antiAlias)
                              .make(),
                          title: boldText(
                              text: "${data[index]['p_name']}",
                              color: textfieldGrey),
                          subtitle: Row(
                            children: [
                              boldText(
                                  text: "${data[index]['p_price']}".numCurrency,
                                  color: lightGrey),
                              10.widthBox,
                              Visibility(
                                  visible: data[index]['is_featured'],
                                  child: boldText(
                                      text: "featured", color: successColor)),
                            ],
                          ),
                          trailing: VxPopupMenu(
                              controller: popCtrl,
                              menuBuilder: () {
                                return Column(
                                  children: List.generate(
                                      popupMenuTitles.length,
                                      (i) => Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(children: [
                                            Icon(
                                              popupMenuIcons[i],
                                              color: data[index]
                                                          ['is_featured'] &&
                                                      i == 0
                                                  ? successColor
                                                  : fontGrey,
                                            ),
                                            5.widthBox,
                                            generalText(
                                              text: data[index]
                                                          ['is_featured'] &&
                                                      i == 0
                                                  ? "Remove feature"
                                                  : popupMenuTitles[i],
                                              color: data[index]
                                                          ['is_featured'] &&
                                                      i == 0
                                                  ? successColor
                                                  : fontGrey,
                                            )
                                          ]).onTap(
                                            () {
                                              popCtrl.hideMenu();
                                              switch (i) {
                                                case 0:
                                                  controller.addRemoveFeature(
                                                      data[index].id,
                                                      data[index]
                                                          ['is_featured']);
                                                  break;
                                                case 1:
                                                  Get.to(() =>
                                                      EditProductScreen(
                                                          productData:
                                                              data[index]));
                                                  break;
                                                case 2:
                                                  controller.removeProduct(
                                                    data[index].id,
                                                  );
                                                  break;
                                                default:
                                              }
                                            },
                                          ))),
                                )
                                    .box
                                    .width(200)
                                    .rounded
                                    .padding(const EdgeInsets.all(10))
                                    .white
                                    .make();
                              },
                              clickType: VxClickType.singleClick,
                              child: const Icon(Icons.more_vert, color: textfieldGrey)),
                        ).box.margin(const EdgeInsets.only(bottom: 10)).make();
                      }),
                    ));
              })),
      floatingActionButton: FloatingActionButton(
          backgroundColor: lightPrimary,
          shape: const CircleBorder(),
          onPressed: () {
            Get.to(() => const AddNewProduct());
          },
          child: const Icon(
            Icons.add,
            color: textfieldGrey,
          )),
    );
  }
}
