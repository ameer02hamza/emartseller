import 'package:emartseller/const/images.dart';
import 'package:emartseller/controllers/home.controller.dart';
import 'package:emartseller/screens/home/home.screen.dart';
import 'package:emartseller/screens/orders/order.screen.dart';
import 'package:emartseller/screens/products/product.screen.dart';
import 'package:emartseller/screens/profiles/profile.screen.dart';
import 'package:get/get.dart';

import '../../const/const.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var bottomNav = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 24,
            color: fontGrey,
          ),
          label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            width: 24,
            color: fontGrey,
          ),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            width: 24,
            color: fontGrey,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSetting,
            width: 24,
            color: fontGrey,
          ),
          label: generalSetting),
    ];
    var navScreens = [
      const HomeScreen(),
      const PorductScreen(),
      const OrderScreen(),
      const ProfileScreen()
    ];
    return Scaffold(
      body: Obx(() => Column(
            children: [
              Expanded(
                child: navScreens.elementAt(controller.navIndex.value),
              )
            ],
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: fontGrey,
          currentIndex: controller.navIndex.value,
          items: bottomNav)),
    );
  }
}
