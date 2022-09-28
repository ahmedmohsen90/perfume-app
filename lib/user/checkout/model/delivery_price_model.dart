// To parse this JSON data, do
//
//     final deliveryPriceModel = deliveryPriceModelFromJson(jsonString);

import 'dart:convert';

DeliveryPriceModel deliveryPriceModelFromJson(String str) =>
    DeliveryPriceModel.fromJson(json.decode(str));

String deliveryPriceModelToJson(DeliveryPriceModel data) =>
    json.encode(data.toJson());

class DeliveryPriceModel {
  DeliveryPriceModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  num? data;

  factory DeliveryPriceModel.fromJson(Map<String, dynamic> json) =>
      DeliveryPriceModel(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}
