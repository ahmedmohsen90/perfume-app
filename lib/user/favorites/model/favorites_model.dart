// To parse this JSON data, do
//
//     final myFavoritesModel = myFavoritesModelFromJson(jsonString);

import 'dart:convert';

MyFavoritesModel myFavoritesModelFromJson(String str) =>
    MyFavoritesModel.fromJson(json.decode(str));

String myFavoritesModelToJson(MyFavoritesModel data) =>
    json.encode(data.toJson());

class MyFavoritesModel {
  MyFavoritesModel({
    this.success,
    this.message,
    this.data,
    this.paginate,
  });

  bool? success;
  String? message;
  List<FavProducts>? data;
  Paginate? paginate;

  factory MyFavoritesModel.fromJson(Map<String, dynamic> json) =>
      MyFavoritesModel(
        success: json["success"],
        message: json["message"],
        data: List<FavProducts>.from(
            json["data"].map((x) => FavProducts.fromJson(x))),
        paginate: null, // Paginate.fromJson(json["paginate"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "paginate": paginate?.toJson(),
      };
}

class FavProducts {
  FavProducts({
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
  List<ProductImages>? images;

  factory FavProducts.fromJson(Map<String, dynamic> json) => FavProducts(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        oldPrice: json["old_price"].toString(),
        newPrice: json["new_price"].toString(),
        inStock: json["in_stock"],
        inWishlist: json["in_wishlist"],
        images: List<ProductImages>.from(
            json["images"].map((x) => ProductImages.fromJson(x))),
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
}

class ProductImages {
  ProductImages({
    this.id,
    this.url,
    this.mime,
  });

  int? id;
  String? url;
  String? mime;

  factory ProductImages.fromJson(Map<String, dynamic> json) => ProductImages(
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

class Paginate {
  Paginate({
    this.currentPage,
    this.hasPages,
    this.nextPageUrl,
    this.perPage,
  });

  int? currentPage;
  bool? hasPages;
  String? nextPageUrl;
  int? perPage;

  factory Paginate.fromJson(Map<String, dynamic> json) => Paginate(
        currentPage: json["current_page"],
        hasPages: json["has_pages"],
        nextPageUrl: json["next_page_url"],
        perPage: json["per_page"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "has_pages": hasPages,
        "next_page_url": nextPageUrl,
        "per_page": perPage,
      };
}
