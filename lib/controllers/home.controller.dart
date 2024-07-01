import 'package:emartseller/const/firebase.const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var navIndex = 0.obs;

  var userName = "".obs;

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
