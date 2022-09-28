// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.toJson());

class CategoriesModel {
  CategoriesModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Categories>? data;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Categories>.from(
                json["data"].map((x) => Categories.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Categories {
  Categories({
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

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
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
