import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emartseller/const/firebase.const.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  changeOrderStatus(title, status, docId) async {
    var store = firebaseStore.collection(orderCollection).doc(docId);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
