import 'package:emartseller/const/firebase.const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var navIndex = 0.obs;
  var userName = "".obs;
  var avgRating = 0.obs;
  var totalProducts = [].obs;
  var totalOrders = [].obs;
  var totalSales = 0.toDouble();
  getRatings() {
    avgRating.value = 0;
    totalProducts.forEach((e) {
      avgRating.value += int.parse(e['p_rating']);
    });
  }

  getTotalSales() {
    totalSales = 0.0;
    totalOrders.forEach((e) {
      totalSales += double.parse(e['total_amount'].toString());
    });
  }

  @override
  void onInit() {
    super.onInit();
    getUserName();
  }

  getUserName() async {
    userName.value = "John Doe";
    var name = await firebaseStore
        .collection(vendorCollections)
        .where("id", isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.first.data()["vendor_name"];
      }
    });
    userName.value = name;
  }
}
