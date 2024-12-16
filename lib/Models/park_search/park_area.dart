// To parse this JSON data, do
//
//     final parkAreaModel = parkAreaModelFromJson(jsonString);

import 'dart:convert';

ParkAreaModel parkAreaModelFromJson(String str) =>
    ParkAreaModel.fromJson(json.decode(str));

String parkAreaModelToJson(ParkAreaModel data) => json.encode(data.toJson());

class ParkAreaModel {
  int id;
  int parkCategoryId;
  String parkName;
  String parkImage;
  int parkCapacity;
  String parkInformation;
  String parkCoordinate;
  DateTime createdAt;
  DateTime updatedAt;

  ParkAreaModel({
    required this.id,
    required this.parkCategoryId,
    required this.parkName,
    required this.parkImage,
    required this.parkCapacity,
    required this.parkInformation,
    required this.parkCoordinate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ParkAreaModel.fromJson(Map<String, dynamic> json) => ParkAreaModel(
        id: json["id"],
        parkCategoryId: json["park_category_id"],
        parkName: json["park_name"],
        parkImage: json["park_image"],
        parkCapacity: json["park_capacity"],
        parkInformation: json["park_information"],
        parkCoordinate: json["park_coordinate"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "park_category_id": parkCategoryId,
        "park_name": parkName,
        "park_image": parkImage,
        "park_capacity": parkCapacity,
        "park_information": parkInformation,
        "park_coordinate": parkCoordinate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
