// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Result>? data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Result>.from(json["data"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Result extends Equatable {
  Result({
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
  List<ResultProductImage>? images;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        oldPrice: json["old_price"].toString(),
        newPrice: json["new_price"].toString(),
        inStock: json["in_stock"],
        inWishlist: json["in_wishlist"],
        images: json["images"] == null
            ? []
            : List<ResultProductImage>.from(
                json["images"].map((x) => ResultProductImage.fromJson(x))),
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

class ResultProductImage {
  ResultProductImage({
    this.id,
    this.url,
    this.mime,
  });

  int? id;
  String? url;
  String? mime;

  factory ResultProductImage.fromJson(Map<String, dynamic> json) =>
      ResultProductImage(
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
