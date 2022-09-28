// To parse this JSON data, do
//
//     final viewProductModel = viewProductModelFromJson(jsonString);

import 'dart:convert';

ViewProductModel viewProductModelFromJson(String str) =>
    ViewProductModel.fromJson(json.decode(str));

String viewProductModelToJson(ViewProductModel data) =>
    json.encode(data.toJson());

class ViewProductModel {
  ViewProductModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  ProductData? data;

  factory ViewProductModel.fromJson(Map<String, dynamic> json) =>
      ViewProductModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : ProductData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProductData {
  ProductData({
    this.id,
    this.name,
    this.oldPrice,
    this.newPrice,
    this.description,
    this.inStock,
    this.inWishlist,
    this.skuCode,
    this.barcode,
    this.taxInfo,
    this.seller,
    this.category,
    this.images,
  });

  int? id;
  String? name;
  String? oldPrice;
  String? newPrice;
  String? description;
  bool? inStock;
  bool? inWishlist;
  dynamic skuCode;
  dynamic barcode;
  String? taxInfo;
  String? seller;
  String? category;
  List<Image>? images;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        name: json["name"],
        oldPrice: json["old_price"].toString(),
        newPrice: json["new_price"].toString(),
        description: json["description"],
        inStock: json["in_stock"],
        inWishlist: json["in_wishlist"],
        skuCode: json["sku_code"],
        barcode: json["barcode"],
        taxInfo: json["tax_info"],
        seller: json["seller"],
        category: json["category"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "old_price": oldPrice,
        "new_price": newPrice,
        "description": description,
        "in_stock": inStock,
        "in_wishlist": inWishlist,
        "sku_code": skuCode,
        "barcode": barcode,
        "tax_info": taxInfo,
        "seller": seller,
        "category": category,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    this.id,
    this.url,
    this.mime,
  });

  int? id;
  String? url;
  String? mime;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        url: json["url"],
        mime: json["mime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "mime": mime,
      };
}
