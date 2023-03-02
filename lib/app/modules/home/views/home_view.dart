import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_qrcode_getx_project/app/controllers/auth_controller.dart';
import 'package:flutter_qrcode_getx_project/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final AuthController authC = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                Map<String, dynamic> result = await authC.logout();
                if (result['error'] == true) {
                  Get.snackbar('Error', result['message']);
                } else {
                  Get.snackbar('Success', result['message']);
                  Get.offAllNamed(Routes.LOGIN);
                }
              },
              icon: const Icon(
                Icons.logout,
                size: 24.0,
              ),
            ),
          ],
        ),
        body: GridView.builder(
          itemCount: 4,
          padding: EdgeInsets.all(15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            late String title;
            late IconData iconData;
            late VoidCallback onTap;

            switch (index) {
              case 0:
                title = 'Add Product';
                iconData = Icons.post_add_rounded;
                onTap = () => Get.toNamed(Routes.ADD_PRODUCT);
                break;
              case 1:
                title = 'Products';
                iconData = Icons.list_alt_outlined;
                onTap = () => Get.toNamed(Routes.PRODUCTS);
                break;
              case 2:
                title = 'QR Code';
                iconData = Icons.qr_code;
                onTap = () async {
                  String barcode = await FlutterBarcodeScanner.scanBarcode(
                    '#000000',
                    'Cancel',
                    true,
                    ScanMode.QR,
                  );

                  Map<String, dynamic> result =
                      await controller.getProductId(barcode);

                  if (result['error'] == false) {
                    Get.toNamed(Routes.DETAIL_PRODUCT,
                        arguments: result['data']);
                    Get.snackbar('Success', result['message']);
                  } else {
                    Get.snackbar('Error', result['message']);
                  }
                };
                break;
              case 3:
                title = 'Catalog';
                iconData = Icons.document_scanner_outlined;
                onTap = () {
                  controller.exportCatalog();
                };
                break;
            }
            return Material(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10.0),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        iconData,
                        size: 50.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("$title"),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
