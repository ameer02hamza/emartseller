import 'package:emartseller/const/images.dart';
import 'package:emartseller/screens/orders/orderDetails.screen.dart';
import 'package:emartseller/widgets/appbar.widget.dart';
import 'package:emartseller/widgets/customButton.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';

import '../../const/const.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: orders),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: List.generate(20, (index) {
                return ListTile(
                    tileColor: textfieldGrey,
                    trailing: boldText(text: "\$2000", color: primaryColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onTap: () {
                      Get.to(() => const OrderDetailScreen());
                    },
                    title: boldText(text: "code213", color: primaryColor),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            5.widthBox,
                            boldText(
                                text: intl.DateFormat.yMMMMEEEEd()
                                    .format(DateTime.now()),
                                color: fontGrey),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.payment),
                            5.widthBox,
                            boldText(text: "unpaid", color: red),
                          ],
                        )
                      ],
                    )).box.margin(const EdgeInsets.only(bottom: 10)).make();
              }),
            )),
      ),
    );
  }
}
