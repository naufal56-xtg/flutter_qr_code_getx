import 'dart:convert';

class ProductsModel {
  ProductsModel({
    required this.codeProduct,
    required this.nameProduct,
    required this.priceProduct,
    required this.productId,
    required this.qtyProduct,
  });

  final String codeProduct;
  final String nameProduct;
  final double priceProduct;
  final String productId;
  final int qtyProduct;

  factory ProductsModel.fromRawJson(String str) =>
      ProductsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        codeProduct: json["code_product"] ?? '',
        nameProduct: json["name_product"] ?? '',
        priceProduct: json["price_product"] ?? 0.0,
        productId: json["product_id"] ?? '',
        qtyProduct: json["qty_product"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "code_product": codeProduct,
        "name_product": nameProduct,
        "price_product": priceProduct,
        "product_id": productId,
        "qty_product": qtyProduct,
      };
}
