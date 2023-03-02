import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_qrcode_getx_project/app/data/models/products_model.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  RxList<ProductsModel> allProducts = List<ProductsModel>.empty().obs;

  void exportCatalog() async {
    final pdf = pw.Document();

    var getData = await firebaseFirestore.collection('products').get();

    allProducts([]);

    getData.docs.forEach((element) {
      allProducts.add(ProductsModel.fromJson(element.data()));
    });

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            List<pw.TableRow> allData =
                List.generate(allProducts.length, (index) {
              ProductsModel product = allProducts[index];
              return pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text('${index + 1}',
                        style: pw.TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: pw.TextAlign.center),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text(product.codeProduct,
                        style: pw.TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: pw.TextAlign.center),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text(product.nameProduct,
                        style: pw.TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: pw.TextAlign.center),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text(product.qtyProduct.toString(),
                        style: pw.TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: pw.TextAlign.center),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.Text(product.priceProduct.toStringAsFixed(0),
                        style: pw.TextStyle(
                          fontSize: 12,
                        ),
                        textAlign: pw.TextAlign.center),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(10),
                    child: pw.BarcodeWidget(
                      color: PdfColor.fromHex('#000000'),
                      barcode: pw.Barcode.qrCode(),
                      data: product.codeProduct,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              );
            });
            return [
              pw.Center(
                child: pw.Text(
                  'ALL PRODUCTS',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                  border: pw.TableBorder.all(
                    color: PdfColor.fromHex('#000000'),
                    width: 2,
                  ),
                  children: [
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Text('No',
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Text('Code Product',
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Text('Name Product',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Text('Qty',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Text('Price',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Text('QR Code',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                              ),
                              textAlign: pw.TextAlign.center),
                        ),
                      ],
                    ),
                    ...allData,
                  ]),
            ];
          }),
    );

    Uint8List bytes = await pdf.save();

    final directory = await getApplicationDocumentsDirectory();
    final pathFile = File('${directory.path}/mydocument.pdf');

    await pathFile.writeAsBytes(bytes);

    await OpenFile.open(pathFile.path);
  }

  Future<Map<String, dynamic>> getProductId(String code) async {
    try {
      final result = await firebaseFirestore
          .collection('products')
          .where('code_product', isEqualTo: code)
          .get();

      if (result.docs.isEmpty) {
        return {
          'error': true,
          'message': 'Not Found Product In Databases',
        };
      }

      Map<String, dynamic> data = result.docs.first.data();

      return {
        'error': false,
        'message': 'Success To Scan Barcode Product',
        'data': ProductsModel.fromJson(data),
      };
    } catch (err) {
      print(err);
      return {
        'error': true,
        'message': 'Failed To Scan Barcode Product',
      };
    }
  }
}
