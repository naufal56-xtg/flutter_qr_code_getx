import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController codeC;
  late TextEditingController nameC;
  late TextEditingController priceC;
  late TextEditingController qtyC;
  var isLoading = false.obs;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    codeC = TextEditingController();
    priceC = TextEditingController();
    nameC = TextEditingController();
    qtyC = TextEditingController();
    super.onInit();
  }

  Future<Map<String, dynamic>> addProduct(
      String codeP, String nameP, double priceP, int qtyP) async {
    try {
      var data = await firebaseFirestore.collection('products').add({
        'code_product': codeP,
        'name_product': nameP,
        'price_product': priceP,
        'qty_product': qtyP
      });

      await firebaseFirestore.collection('products').doc(data.id).update({
        'product_id': data.id,
      });

      return {
        'error': false,
        'message': 'Success Add Item To Product',
      };
    } catch (err) {
      print(err);
      return {
        'error': true,
        'message': 'Failed Add item To Product',
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
