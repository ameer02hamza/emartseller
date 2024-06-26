import 'package:emartseller/const/firebase.const.dart';

class StoreService {
  static getProfile() {
    return firebaseStore
        .collection(vendorCollections)
        .where("id", isEqualTo: currentUser!.uid)
        .get();
  }
}
