// To parse this JSON data, do
//
//     final toggleProductModel = toggleProductModelFromJson(jsonString);

import 'dart:convert';

ToggleProductModel toggleProductModelFromJson(String str) =>
    ToggleProductModel.fromJson(json.decode(str));

String toggleProductModelToJson(ToggleProductModel data) =>
    json.encode(data.toJson());

class ToggleProductModel {
  ToggleProductModel({
    this.success,
    this.message,
  });

  bool? success;
  String? message;

  factory ToggleProductModel.fromJson(Map<String, dynamic> json) =>
      ToggleProductModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
