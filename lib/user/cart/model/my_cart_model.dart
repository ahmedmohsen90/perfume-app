// To parse this JSON data, do
//
//     final myCartModel = myCartModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

MyCartModel myCartModelFromJson(String str) =>
    MyCartModel.fromJson(json.decode(str));

String myCartModelToJson(MyCartModel data) => json.encode(data.toJson());

class MyCartModel {
  MyCartModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  CartData? data;

  factory MyCartModel.fromJson(Map<String, dynamic> json) => MyCartModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : CartData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class CartData {
  CartData({
    this.id,
    this.total,
    this.products,
  });

  int? id;
  num? total;
  List<Product>? products;

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
        id: json["id"],
        total: json["total"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total": total,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product extends Equatable {
  Product({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.total,
    this.image,
  });

  int? id;
  String? name;
  String? price;
  int? quantity;
  String? total;
  String? image;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"].toString(),
        quantity: json["quantity"],
        total: json["total"].toString(),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "quantity": quantity,
        "total": total,
        "image": image,
      };

  @override
  List<Object?> get props => [
        name,
        id,
        price,
        quantity,
        total,
        image,
      ];
}
