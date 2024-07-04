import 'package:emartseller/controllers/orders.controller.dart';
import 'package:emartseller/screens/orders/orderDetails.screen.dart';
import 'package:emartseller/services/store.service.dart';
import 'package:emartseller/widgets/appbar.widget.dart';
import 'package:emartseller/widgets/loading.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBarWidget(title: orders),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: StreamBuilder(
              stream: StoreService.getOrdersByVendor(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: loadingIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  return SizedBox(
                    height: context.screenHeight * 0.8,
                    child: Center(
                        child: boldText(
                            text: "No Orders available",
                            color: fontGrey,
                            size: 18)),
                  );
                }
                var data = snapshot.data.docs;
                return Column(
                  children: List.generate(
                      data.length,
                      (index) => ListTile(
                          tileColor: lightPrimary,
                          trailing:
                              boldText(text: "\$2000", color: textfieldGrey),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onTap: () {
                            Get.to(() => OrderDetailScreen(
                                  orderData: data[index],
                                ));
                          },
                          title: boldText(text: "code213", color: textfieldGrey),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month, color: textfieldGrey,),
                                  5.widthBox,
                                  boldText(
                                      text: intl.DateFormat.yMMMMEEEEd()
                                          .format(DateTime.now()),
                                      color: textfieldGrey),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.payment, color: textfieldGrey,),
                                  5.widthBox,
                                  boldText(text: "unpaid", color: white),
                                ],
                              )
                            ],
                          )).box.margin(const EdgeInsets.only(bottom: 10)).make()),
                );
              },
            )),
      ),
    );
  }
}
