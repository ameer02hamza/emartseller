import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartseller/const/images.dart';
import 'package:emartseller/controllers/home.controller.dart';
import 'package:emartseller/screens/products/productDetails.screen.dart';
import 'package:emartseller/services/store.service.dart';
import 'package:emartseller/widgets/appbar.widget.dart';
import 'package:emartseller/widgets/dashboardButton.widget.dart';
import 'package:emartseller/widgets/loading.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';
import '../../const/const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Scaffold(
        appBar: appBarWidget(title: dashboard),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(
                              count: controller
                                  .totalProducts.length, //. toString(),
                              title: products,
                              icon: icProducts),
                          dashboardButton(
                              count: "32", title: orders, icon: icOrders)
                        ],
                      ),
                    ),
                    10.heightBox,
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(
                              count: (controller.avgRating.value /
                                      controller.totalProducts.length)
                                  .toString()
                                  .substring(0, 3),
                              title: rating,
                              icon: icStar),
                          dashboardButton(
                            count: "503".numCurrency.toString(),
                            title: totalSales,
                            icon: icAccount,
                          )
                        ],
                      ),
                    ),
                    10.heightBox,
                    const Divider(),
                    StreamBuilder(
                        stream: StoreService.getProductsByVendor(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: loadingIndicator());
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                                child: boldText(
                                    text:
                                        "None of the products are considered popular.",
                                    color: fontGrey,
                                    size: 18));
                          }
                          var data = snapshot.data!.docs;
                          data = data.sortedBy((a, b) => b['p_wishlist']
                              .length
                              .compareTo(a['p_wishlist'].length));
                          controller.totalProducts.clear();
                          controller.totalProducts.addAll(data);
                          controller.getRatings();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              semiBoldText(
                                  text: popular, color: fontGrey, size: 18),
                              10.heightBox,
                              ListView(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                children: List.generate(data.length, (index) {
                                  return data[index]['p_wishlist'].length > 0
                                      ? ListTile(
                                          onTap: () {
                                            Get.to(() => ProductDetailsScreen(
                                                  productData: data[index],
                                                ));
                                          },
                                          leading: Image.network(
                                                  data[index]["p_imgs"][0])
                                              .box
                                              .roundedSM
                                              .clip(Clip.antiAlias)
                                              .make(),
                                          title: boldText(
                                              text: "${data[index]["p_name"]}",
                                              color: fontGrey),
                                          subtitle: boldText(
                                              text: "${data[index]["p_price"]}"
                                                  .numCurrency,
                                              color: darkGrey),
                                        )
                                      : const SizedBox(
                                          height: 0,
                                        );
                                }),
                              )
                            ],
                          );
                        }),
                  ],
                ))));
  }
}
