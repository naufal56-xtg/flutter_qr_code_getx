import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qrcode_getx_project/app/data/models/products_model.dart';
import 'package:flutter_qrcode_getx_project/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PRODUCTS'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.getProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          List<ProductsModel> allProducts = [];

          snapshot.data!.docs.forEach((element) {
            allProducts.add(ProductsModel.fromJson(element.data()));
          });

          return ListView.builder(
            itemCount: allProducts.length,
            padding: EdgeInsets.all(15),
            itemBuilder: (_, index) {
              ProductsModel dataProduct = allProducts[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Material(
                  color: Colors.grey.shade300,
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.DETAIL_PRODUCT,
                        arguments: dataProduct),
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 158,
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dataProduct.codeProduct,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        dataProduct.nameProduct,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Price : Rp. ${dataProduct.priceProduct.toInt()}",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Qty : ${int.tryParse(dataProduct.qtyProduct.toString()) ?? 0}",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 75,
                                width: 75,
                                child: QrImage(
                                  data: dataProduct.codeProduct,
                                  size: 200,
                                  version: QrVersions.auto,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: 'Delete Item Product',
                                middleText:
                                    'Are You Sure Delete This Item Product ?',
                                barrierDismissible: false,
                                textCancel: 'No',
                                textConfirm: 'Yes',
                                confirmTextColor: Colors.white,
                                onConfirm: () async {
                                  Map<String, dynamic> result = await controller
                                      .deleteProduct(dataProduct.productId);
                                  if (result['error'] == true) {
                                    Get.snackbar('Error', result['message']);
                                  } else {
                                    Get.back();
                                    Get.snackbar('Success', result['message']);
                                    // Get.reload();
                                  }
                                },
                                onCancel: () => Get.back(),
                              );
                            },
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
