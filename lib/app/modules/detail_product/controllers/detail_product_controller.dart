import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
  late TextEditingController codeC;
  late TextEditingController nameC;
  late TextEditingController priceC;
  late TextEditingController qtyC;
  var isLoading = false.obs;
  var isLoadingDelete = false.obs;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    codeC = TextEditingController();
    priceC = TextEditingController();
    nameC = TextEditingController();
    qtyC = TextEditingController();
    super.onInit();
  }

  Future<Map<String, dynamic>> updateProduct(
      String productId, String nameP, double priceP, int qtyP) async {
    try {
      await firebaseFirestore.collection('products').doc(productId).update({
        'name_product': nameP,
        'price_product': priceP,
        'qty_product': qtyP
      });

      return {
        'error': false,
        'message': 'Success Update Item Product',
      };
    } catch (err) {
      print(err);
      return {
        'error': true,
        'message': 'Failed Update Item Product',
      };
    }
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

  @override
  void onClose() {
    codeC.dispose();
    priceC.dispose();
    nameC.dispose();
    qtyC.dispose();
    super.onClose();
  }
}
