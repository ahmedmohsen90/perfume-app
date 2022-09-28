// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

CitiesModel citiesModelFromJson(String str) =>
    CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  CitiesModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Cities>? data;

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Cities>.from(json["data"].map((x) => Cities.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Cities {
  Cities({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
