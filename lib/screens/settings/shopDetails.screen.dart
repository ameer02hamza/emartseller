import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartseller/const/colors.dart';
import 'package:emartseller/const/const.dart';
import 'package:emartseller/controllers/profile.controller.dart';
import 'package:emartseller/screens/settings/components/details.component.dart';
import 'package:emartseller/screens/settings/shopsetting.screen.dart';
import 'package:emartseller/services/store.service.dart';
import 'package:emartseller/widgets/loading.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopDetailsScreen extends StatefulWidget {
  const ShopDetailsScreen({super.key});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  var controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: 'Shop Details', size: 20, color: fontGrey),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: StreamBuilder(
                stream: StoreService.getVendorDetails(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: loadingIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return SizedBox(
                      height: context.screenHeight * 0.8,
                      child: SizedBox(
                        height: context.screenHeight * 0.8,
                        child: Center(
                            child: boldText(
                                text: "No Record Found",
                                color: primaryColor,
                                size: 20)),
                      ),
                    );
                  }
                  controller.shopSnapData = snapshot.data!.docs;
                  return Column(
                    children:
                        List.generate(controller.shopSnapData.length, (index) {
                      if (controller.shopSnapData[index]['is_primary']) {
                        controller.primaryIndex.value = index;
                      }
                      return detailsCard(
                              context: context,
                              index: index,
                              width: context.screenWidth * 0.7)
                          .onTap(() async {
                        if (controller.shopSnapData[index]['is_primary']) {
                          return;
                        }
                        await controller.updatePrimaryAddress(
                            controller.shopSnapData[index].id);
                      });
                    }),
                  );
                })),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          shape: const CircleBorder(),
          onPressed: () {
            Get.to(() => const ShopSettingScreen());
          },
          child: const Icon(
            Icons.add,
            color: white,
          )),
    );
  }
}
