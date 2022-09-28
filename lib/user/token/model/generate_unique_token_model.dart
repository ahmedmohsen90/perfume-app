// To parse this JSON data, do
//
//     final generateUniqueTokenModel = generateUniqueTokenModelFromJson(jsonString);

import 'dart:convert';

GenerateUniqueTokenModel generateUniqueTokenModelFromJson(String str) => GenerateUniqueTokenModel.fromJson(json.decode(str));

String generateUniqueTokenModelToJson(GenerateUniqueTokenModel data) => json.encode(data.toJson());

class GenerateUniqueTokenModel {
    GenerateUniqueTokenModel({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    String? message;
    String? data;

    factory GenerateUniqueTokenModel.fromJson(Map<String, dynamic> json) => GenerateUniqueTokenModel(
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
