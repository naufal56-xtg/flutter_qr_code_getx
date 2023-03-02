import 'package:flutter/material.dart';
import 'package:flutter_qrcode_getx_project/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD PRODUCT'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          FieldProductWidget(
            controller: controller.codeC,
            textInputType: TextInputType.number,
            label: 'Product Code',
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
                if (controller.codeC.text.isNotEmpty &&
                    controller.qtyC.text.isNotEmpty &&
                    controller.nameC.text.isNotEmpty &&
                    controller.priceC.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> result = await controller.addProduct(
                      controller.codeC.text,
                      controller.nameC.text,
                      double.tryParse(controller.priceC.text) ?? 0,
                      int.tryParse(controller.qtyC.text) ?? 0);
                  controller.isLoading(false);
                  if (result['error'] == true) {
                    Get.snackbar('Error', result['message']);
                  } else {
                    Get.snackbar('Success', result['message']);
                    // Get.back();
                    Get.offAllNamed(Routes.HOME);
                  }
                } else {
                  Get.snackbar('Error', 'Email / Password Can Be Empty');
                }
              }
            },
            child: Obx(
              () => Text(
                controller.isLoading.isFalse ? "Add Product" : 'Loading...',
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
        ],
      ),
    );
  }
}

class FieldProductWidget extends StatelessWidget {
  const FieldProductWidget({
    Key? key,
    required this.controller,
    required this.textInputType,
    required this.label,
    this.maxLenght,
    this.readOnly,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType textInputType;
  final String label;
  final int? maxLenght;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: false,
      readOnly: readOnly ?? false,
      keyboardType: textInputType,
      maxLength: maxLenght,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
