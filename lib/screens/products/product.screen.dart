import 'package:emartseller/const/images.dart';
import 'package:emartseller/screens/products/addNew.screen.dart';
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
    return Scaffold(
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
                    child: boldText(text: "No Products found", color: fontGrey),
                  );
                }
                var data = snapshot.data.docs;
                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(data.length, (index) {
                        return ListTile(
                          tileColor: primaryColor.withOpacity(0.2),
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
                              color: fontGrey),
                          subtitle: Row(
                            children: [
                              boldText(
                                  text: "${data[index]['p_price']}".numCurrency,
                                  color: darkGrey),
                              10.widthBox,
                              Visibility(
                                  visible: data[index]['is_featured'],
                                  child: boldText(
                                      text: "featured", color: successColor)),
                            ],
                          ),
                          trailing: VxPopupMenu(
                              menuBuilder: () {
                                return Column(
                                  children: List.generate(
                                      popupMenuTitles.length,
                                      (index) => Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(children: [
                                            Icon(popupMenuIcons[index]),
                                            5.widthBox,
                                            generalText(
                                                text: popupMenuTitles[index],
                                                color: fontGrey)
                                          ]).onTap(
                                            () {},
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
                              child: const Icon(Icons.more_vert)),
                        ).box.margin(const EdgeInsets.only(bottom: 10)).make();
                      }),
                    ));
              })),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          shape: const CircleBorder(),
          onPressed: () {
            Get.to(() => const AddNewProduct());
          },
          child: const Icon(
            Icons.add,
            color: white,
          )),
    );
  }
}
