// To parse this JSON data, do
//
//     final missionModel = missionModelFromJson(jsonString);

import 'dart:convert';

MissionModel missionModelFromJson(String str) =>
    MissionModel.fromJson(json.decode(str));

String missionModelToJson(MissionModel data) => json.encode(data.toJson());

class MissionModel {
  int id;
  int userId;
  int missionId;
  int streak;
  String status;
  dynamic weekNumber;
  DateTime createdAt;
  DateTime updatedAt;
  Mission mission;

  MissionModel({
    required this.id,
    required this.userId,
    required this.missionId,
    required this.streak,
    required this.status,
    required this.weekNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.mission,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) => MissionModel(
        id: json["id"],
        userId: json["user_id"],
        missionId: json["mission_id"],
        streak: json["streak"],
        status: json["status"],
        weekNumber: json["week_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mission: Mission.fromJson(json["mission"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "mission_id": missionId,
        "streak": streak,
        "status": status,
        "week_number": weekNumber,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "mission": mission.toJson(),
      };
}

class Mission {
  int id;
  int missionCategoryId;
  int rewardId;
  dynamic rankId;
  String missionName;
  String missionDescription;
  dynamic dayStart;
  dynamic dayEnd;
  DateTime createdAt;
  DateTime updatedAt;

  Mission({
    required this.id,
    required this.missionCategoryId,
    required this.rewardId,
    required this.rankId,
    required this.missionName,
    required this.missionDescription,
    required this.dayStart,
    required this.dayEnd,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Mission.fromJson(Map<String, dynamic> json) => Mission(
        id: json["id"],
        missionCategoryId: json["mission_category_id"],
        rewardId: json["reward_id"],
        rankId: json["rank_id"],
        missionName: json["mission_name"],
        missionDescription: json["mission_description"],
        dayStart: json["day_start"],
        dayEnd: json["day_end"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mission_category_id": missionCategoryId,
        "reward_id": rewardId,
        "rank_id": rankId,
        "mission_name": missionName,
        "mission_description": missionDescription,
        "day_start": dayStart,
        "day_end": dayEnd,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
