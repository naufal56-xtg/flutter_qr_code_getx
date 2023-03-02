import 'package:flutter/material.dart';
import 'package:flutter_qrcode_getx_project/app/data/models/products_model.dart';
import 'package:flutter_qrcode_getx_project/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../add_product/views/add_product_view.dart';
import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({Key? key}) : super(key: key);

  final ProductsModel dataProduct = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.codeC.text = dataProduct.codeProduct;
    controller.nameC.text = dataProduct.nameProduct;
    controller.priceC.text = dataProduct.priceProduct.toStringAsFixed(0);
    controller.qtyC.text = dataProduct.qtyProduct.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('DETAIL PRODUCT'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: QrImage(
                  data: dataProduct.codeProduct,
                  size: 200,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          FieldProductWidget(
            controller: controller.codeC,
            textInputType: TextInputType.number,
            label: 'Product Code',
            readOnly: true,
            maxLenght: 10,
          ),
          SizedBox(
            height: 10,
          ),
          FieldProductWidget(
            controller: controller.nameC,
            textInputType: TextInputType.text,
            label: 'Name Product',
          ),
          SizedBox(
            height: 10,
          ),
          FieldProductWidget(
            controller: controller.priceC,
            textInputType: TextInputType.number,
            label: 'Price Product',
          ),
          SizedBox(
            height: 10,
          ),
          FieldProductWidget(
            controller: controller.qtyC,
            textInputType: TextInputType.number,
            label: 'Quantity (Qty) Product',
          ),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (controller.qtyC.text.isNotEmpty &&
                    controller.nameC.text.isNotEmpty &&
                    controller.priceC.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> result = await controller.updateProduct(
                      dataProduct.productId,
                      controller.nameC.text,
                      double.tryParse(controller.priceC.text) ?? 0,
                      int.tryParse(controller.qtyC.text) ?? 0);
                  controller.isLoading(false);
                  if (result['error'] == true) {
                    Get.snackbar('Error', result['message']);
                  } else {
                    Get.snackbar('Success', result['message']);
                    Get.toNamed(Routes.PRODUCTS);
                  }
                } else {
                  Get.snackbar('Error', 'Email / Password Can Be Empty');
                }
              }
            },
            child: Obx(
              () => Text(
                controller.isLoading.isFalse ? "Update Product" : 'Loading...',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextButton(
            onPressed: () async {
              Map<String, dynamic> result =
                  await controller.deleteProduct(dataProduct.productId);
              if (result['error'] == true) {
                Get.snackbar('Error', result['message']);
              } else {
                Get.back();
                Get.snackbar('Success', result['message']);
                // Get.toNamed(Routes.PRODUCTS);
              }
            },
            child: Obx(
              () => Text(
                controller.isLoadingDelete.isFalse
                    ? "Delete Product"
                    : 'Loading...',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
