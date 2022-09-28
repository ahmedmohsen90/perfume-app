// To parse this JSON data, do
//
//     final areasModel = areasModelFromJson(jsonString);

import 'dart:convert';

AreasModel areasModelFromJson(String str) =>
    AreasModel.fromJson(json.decode(str));

String areasModelToJson(AreasModel data) => json.encode(data.toJson());

class AreasModel {
  AreasModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Area>? data;

  factory AreasModel.fromJson(Map<String, dynamic> json) => AreasModel(
        success: json["success"],
        message: json["message"],
        data: List<Area>.from(json["data"] == null
            ? []
            : json["data"].map((x) => Area.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Area {
  Area({
    this.id,
    this.name,
    this.deliveryPrice,
  });

  int? id;
  String? name;
  int? deliveryPrice;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
        deliveryPrice: json["delivery_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "delivery_price": deliveryPrice,
      };
}
