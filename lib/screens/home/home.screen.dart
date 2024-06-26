import 'package:emartseller/const/images.dart';
import 'package:emartseller/screens/products/productDetails.screen.dart';
import 'package:emartseller/widgets/appbar.widget.dart';
import 'package:emartseller/widgets/dashboardButton.widget.dart';
import 'package:emartseller/widgets/textStyle.widget.dart';
import 'package:get/get.dart';
import '../../const/const.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: dashboard),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(count: "49", title: products, icon: icProducts),
                dashboardButton(count: "32", title: orders, icon: icOrders)
              ],
            ),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(count: "4.6", title: rating, icon: icStar),
                dashboardButton(
                    count: "503".numCurrency.toString(),
                    title: totalSales,
                    icon: icAccount)
              ],
            ),
            10.heightBox,
            const Divider(),
            semiBoldText(text: popular, color: fontGrey, size: 18),
            10.heightBox,
            ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(3, (index) {
                return ListTile(
                  onTap: () {
                    Get.to(() => const ProductDetailsScreen());
                  },
                  leading: Image.asset(imgProduct)
                      .box
                      .roundedSM
                      .clip(Clip.antiAlias)
                      .make(),
                  title: boldText(text: "Product Name", color: fontGrey),
                  subtitle: boldText(text: "\$2000", color: darkGrey),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
