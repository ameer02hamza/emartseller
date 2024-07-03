import 'package:emartseller/const/firebase.const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var navIndex = 0.obs;
  var userName = "".obs;
  var avgRating = 0.obs;
  var totalProducts = [].obs;

  getRatings() {
    avgRating.value = 0;
    totalProducts.forEach((e) {
      avgRating.value += int.parse(e['p_rating']);
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
    print("%c $userName");
  }
}
