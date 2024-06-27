import 'package:emartseller/const/const.dart';
import 'package:emartseller/controllers/orders.controller.dart';
import 'package:emartseller/screens/orders/components/orderPlace.component.dart';
import 'package:emartseller/screens/orders/components/orderStatus.component.dart';
import 'package:emartseller/widgets/customButton.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetailScreen extends StatefulWidget {
  var orderData;
  OrderDetailScreen({super.key, required this.orderData});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool orderConfirmed = false;
  bool onDelivery = false;
  bool orderDelivered = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderConfirmed = widget.orderData["order_confirmed"];
    onDelivery = widget.orderData["order_on_delivery"];
    orderDelivered = widget.orderData["order_delivered"];
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: semiBoldText(text: "Order Details", color: fontGrey),
      ),
      bottomNavigationBar: customButton(
          title: "Confirm Order",
          bgColor: successColor,
          onPressed: () {
            controller.changeOrderStatus(
                "order_confirmed", true, widget.orderData.id);
            setState(() {
              orderConfirmed = true;
            });
          },
          textColor: white),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                Visibility(
                  visible: orderConfirmed,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(text: "Order Status", color: fontGrey, size: 16),
                      SwitchListTile(
                        activeColor: successColor,
                        value: widget.orderData['order_placed'],
                        onChanged: (value) {},
                        title: boldText(text: "Placed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: successColor,
                        value: widget.orderData['order_confirmed'],
                        onChanged: (value) {},
                        title: boldText(text: "Confirmed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: successColor,
                        value: onDelivery,
                        onChanged: (value) {
                          controller.changeOrderStatus(
                              "order_on_delivery", true, widget.orderData.id);
                          setState(() {
                            onDelivery = true;
                          });
                        },
                        title: boldText(text: "On transit", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: successColor,
                        value: orderDelivered,
                        onChanged: (value) {
                          controller.changeOrderStatus(
                              "order_delivered", true, widget.orderData.id);
                          setState(() {
                            orderDelivered = true;
                          });
                        },
                        title: boldText(text: "Delivered", color: fontGrey),
                      ),
                    ],
                  )
                      .box
                      .outerShadowMd
                      .white
                      .padding(const EdgeInsets.all(10))
                      .border(color: lightGrey)
                      .roundedSM
                      .make(),
                ),
                orderStatus(
                  color: primaryColor,
                  icon: Icons.done,
                  title: "Placed",
                  showDone: widget.orderData['order_placed'],
                ),
                orderStatus(
                  color: Colors.blue,
                  icon: Icons.thumb_up,
                  title: "Confirmed",
                  showDone: widget.orderData['order_confirmed'],
                ),
                orderStatus(
                  color: const Color.fromRGBO(230, 207, 1, 1),
                  icon: Icons.car_crash,
                  title: "In Transition",
                  showDone: widget.orderData['order_on_delivery'],
                ),
                orderStatus(
                  color: successColor,
                  icon: Icons.done_all,
                  title: "Delivered",
                  showDone: widget.orderData['order_delivered'],
                ),
                const Divider(),
                Column(
                  children: [
                    orderPlaceDetails(
                        title1: "Order Code",
                        d1: widget.orderData['order_code'],
                        title2: "Shipping Method",
                        d2: widget.orderData['shipping_method']),
                    orderPlaceDetails(
                        title1: "Order Date",
                        d1: intl.DateFormat.yMMMMd('en_US').format(
                            DateTime.parse(
                                widget.orderData['order_time'].toString())),
                        title2: "Payment Method",
                        d2: widget.orderData['payment_method']),
                    orderPlaceDetails(
                        title1: "Payment Status",
                        d1: "Unpaid",
                        title2: "Delivery Status",
                        d2: widget.orderData['order_delivered']
                        // ? "Delivered"
                        // : "Not Delivered"
                        ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    text: "Shipping Address",
                                    color: textfieldGrey),
                                boldText(
                                    text: widget.orderData['order_by_address'],
                                    color: textfieldGrey),
                                boldText(
                                    text: widget.orderData['order_by_name'],
                                    color: textfieldGrey),
                                boldText(
                                    text: widget.orderData['order_by_phone'],
                                    color: textfieldGrey),
                                boldText(
                                    text:
                                        widget.orderData['order_by_postalcode'],
                                    color: textfieldGrey),
                                boldText(
                                    text:
                                        "Dubai", //widget.orderData['order_by_city'],
                                    color: textfieldGrey),
                                boldText(
                                    text:
                                        "UAE", //widget.orderData['order_by_country'],
                                    color: textfieldGrey)
                              ],
                            ),
                            SizedBox(
                                width: context.screenWidth / 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    boldText(
                                        text: "Total Amount",
                                        color: textfieldGrey),
                                    boldText(
                                        text: widget.orderData['total_amount'],
                                        color: primaryColor),
                                  ],
                                ))
                          ],
                        ))
                  ],
                )
                    .box
                    .outerShadowMd
                    .white
                    .padding(const EdgeInsets.all(10))
                    .make(),
                const Divider(),
                boldText(text: "Ordered Product", color: textfieldGrey)
                    .box
                    .makeCentered(),
                10.heightBox,
                ListView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(widget.orderData["orders"].length,
                      // widget.orderData['orders'].length,
                      (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                            title1: widget.orderData['orders'][index]['title'],
                            d1: widget.orderData['orders'][index]['qty'],
                            title2: widget.orderData['orders'][index]
                                ['totalPrice'],
                            d2: "Refundable"),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                              width: 30, height: 10, color: Colors.amber
                              // Color(int.parse(
                              //     widget.orderData['orders'][index]["color"]))
                              ),
                        ),
                        const Divider()
                      ],
                    );
                  }).toList(),
                )
                    .box
                    .outerShadowMd
                    .white
                    .padding(const EdgeInsets.all(10))
                    .make(),
                10.heightBox,
              ]))),
    );
  }
}
