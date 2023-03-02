import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getProduct() async* {
    yield* firebaseFirestore.collection('products').snapshots();
  }

  Future<Map<String, dynamic>> deleteProduct(String productId) async {
    try {
      await firebaseFirestore.collection('products').doc(productId).delete();

      return {
        'error': false,
        'message': 'Success Delete Item Product',
      };
    } catch (err) {
      print(err);
      return {
        'error': true,
        'message': 'Failed Delete Item Product',
      };
    }
  }
}
