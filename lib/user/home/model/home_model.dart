// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  HomeModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.sliders,
    this.categories,
    this.suggestProducts,
    this.bestSellerProducts,
  });

  List<Sliders>? sliders;
  List<Category>? categories;
  List<Product>? suggestProducts;
  List<Product>? bestSellerProducts;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sliders: json["sliders"] == null
            ? []
            : List<Sliders>.from(
                json["sliders"].map((x) => Sliders.fromJson(x))),
        categories: List<Category>.from(json["categories"] == null
            ? []
            : json["categories"].map((x) => Category.fromJson(x))),
        suggestProducts: List<Product>.from(json["suggest_products"] == null
            ? []
            : json["suggest_products"].map((x) => Product.fromJson(x))),
        bestSellerProducts: List<Product>.from(
            json["best_seller_products"] == null
                ? []
                : json["best_seller_products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sliders": List<dynamic>.from(sliders!.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "suggest_products":
            List<dynamic>.from(suggestProducts!.map((x) => x.toJson())),
        "best_seller_products":
            List<dynamic>.from(bestSellerProducts!.map((x) => x.toJson())),
      };
}

class Product extends Equatable {
  Product({
    this.id,
    this.slug,
    this.name,
    this.oldPrice,
    this.newPrice,
    this.inStock,
    this.inWishlist,
    this.images,
  });

  int? id;
  String? slug;
  String? name;
  String? oldPrice;
  String? newPrice;
  bool? inStock;
  bool? inWishlist;
  List<Sliders>? images;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        oldPrice: json["old_price"].toString(),
        newPrice: json["new_price"].toString(),
        inStock: json["in_stock"],
        inWishlist: json["in_wishlist"],
        images: json["images"] == null
            ? []
            : List<Sliders>.from(
                json["images"].map((x) => Sliders.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "old_price": oldPrice,
        "new_price": newPrice,
        "in_stock": inStock,
        "in_wishlist": inWishlist,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        id,
        slug,
        name,
        oldPrice,
        newPrice,
        inStock,
        inWishlist,
      ];
}

class Sliders {
  Sliders({
    this.id,
    this.url,
    this.mime,
    this.type,
  });

  int? id;
  String? url;
  String? mime;
  String? type;

  factory Sliders.fromJson(Map<String, dynamic> json) => Sliders(
        id: json["id"],
        url: json["url"],
        mime: json["mime"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "mime": mime,
        "type": type,
      };
}

class Category {
  Category({
    this.id,
    this.slug,
    this.name,
    this.image,
    this.products,
  });

  int? id;
  String? slug;
  String? name;
  String? image;
  int? products;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        image: json["image"],
        products: json["products"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "image": image,
        "products": products,
      };
}
