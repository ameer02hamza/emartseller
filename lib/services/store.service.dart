import 'package:emartseller/const/firebase.const.dart';

class StoreService {
  static getProfile() {
    return firebaseStore
        .collection(vendorCollections)
        .where("id", isEqualTo: currentUser!.uid)
        .get();
  }

  static getOrdersByVendor() {
    return firebaseStore
        .collection(orderCollection)
        .where("vendor", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getProductsByVendor() {
    return firebaseStore
        .collection(productCollections)
        .where("vendor_id", isEqualTo: currentUser!.uid)
        .snapshots();
  }
}
