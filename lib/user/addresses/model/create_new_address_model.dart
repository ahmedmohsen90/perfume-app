// To parse this JSON data, do
//
//     final createNewAddressModel = createNewAddressModelFromJson(jsonString);

import 'dart:convert';

CreateNewAddressModel createNewAddressModelFromJson(String str) => CreateNewAddressModel.fromJson(json.decode(str));

String createNewAddressModelToJson(CreateNewAddressModel data) => json.encode(data.toJson());

class CreateNewAddressModel {
    CreateNewAddressModel({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    String? message;
    AddressData? data;

    factory CreateNewAddressModel.fromJson(Map<String, dynamic> json) => CreateNewAddressModel(
        success: json["success"],
        message: json["message"],
        data:json["data"]==null?null: AddressData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class AddressData {
    AddressData({
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

    factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
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
}
