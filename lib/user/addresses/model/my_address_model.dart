// To parse this JSON data, do
//
//     final myAddressModel = myAddressModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

MyAddressModel myAddressModelFromJson(String str) =>
    MyAddressModel.fromJson(json.decode(str));

String myAddressModelToJson(MyAddressModel data) => json.encode(data.toJson());

class MyAddressModel {
  MyAddressModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Address>? data;

  factory MyAddressModel.fromJson(Map<String, dynamic> json) => MyAddressModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Address>.from(json["data"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Address extends Equatable {
  Address({
    this.id,
    this.title,
    this.name,
    this.email,
    this.mobile,
    this.area,
    this.city,
    this.block,
    this.street,
    this.apartmentNo,
    this.avenue,
    this.isDefault,
  });

  int? id;
  dynamic title;
  String? name;
  String? email;
  String? mobile;
  String? area;
  String? city;
  String? block;
  String? street;
  String? apartmentNo;
  String? avenue;
  int? isDefault;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        title: json["title"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        area: json["area"],
        city: json["city"],
        block: json["block"],
        street: json["street"],
        apartmentNo: json["apartment_no"],
        avenue: json["avenue"],
        isDefault: json["is_default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "name": name,
        "email": email,
        "mobile": mobile,
        "area": area,
        "city": city,
        "block": block,
        "street": street,
        "apartment_no": apartmentNo,
        "avenue": avenue,
        "is_default": isDefault,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        name,
        mobile,
        email,
        area,
        city,
        street,
        block,
        apartmentNo,
        avenue,
        isDefault,
      ];
}
