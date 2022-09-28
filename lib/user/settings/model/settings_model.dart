// To parse this JSON data, do
//
//     final settingsModel = settingsModelFromJson(jsonString);

import 'dart:convert';

SettingsModel settingsModelFromJson(String str) =>
    SettingsModel.fromJson(json.decode(str));

String settingsModelToJson(SettingsModel data) => json.encode(data.toJson());

class SettingsModel {
  SettingsModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  SettingsData? data;

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : SettingsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class SettingsData {
  SettingsData({
    this.name,
    this.logo,
    this.icon,
    this.address,
    this.email,
    this.phone,
    this.whatsapp,
    this.facebook,
    this.instagram,
    this.twitter,
    this.snapchat,
    this.about,
  });

  String? name;
  String? logo;
  dynamic icon;
  String? address;
  String? email;
  String? phone;
  dynamic whatsapp;
  dynamic facebook;
  dynamic instagram;
  dynamic twitter;
  dynamic snapchat;
  dynamic about;

  factory SettingsData.fromJson(Map<String, dynamic> json) => SettingsData(
        name: json["name"],
        logo: json["logo"],
        icon: json["icon"],
        address: json["address"],
        email: json["email"],
        phone: json["phone"],
        whatsapp: json["whatsapp"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        snapchat: json["snapchat"],
        about: json["about"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "icon": icon,
        "address": address,
        "email": email,
        "phone": phone,
        "whatsapp": whatsapp,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "snapchat": snapchat,
        "about": about,
      };
}
