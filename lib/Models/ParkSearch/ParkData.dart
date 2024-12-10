// To parse this JSON data, do
//
//     final parkDataModel = parkDataModelFromJson(jsonString);

import 'dart:convert';

ParkDataModel parkDataModelFromJson(String str) =>
    ParkDataModel.fromJson(json.decode(str));

String parkDataModelToJson(ParkDataModel data) => json.encode(data.toJson());

class ParkDataModel {
  int id;
  int parkAreaId;
  int startHour;
  int endHour;
  int available;
  DateTime createdAt;
  DateTime updatedAt;

  ParkDataModel({
    required this.id,
    required this.parkAreaId,
    required this.startHour,
    required this.endHour,
    required this.available,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ParkDataModel.fromJson(Map<String, dynamic> json) => ParkDataModel(
        id: json["id"],
        parkAreaId: json["park_area_id"],
        startHour: json["start_hour"],
        endHour: json["end_hour"],
        available: json["available"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "park_area_id": parkAreaId,
        "start_hour": startHour,
        "end_hour": endHour,
        "available": available,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
