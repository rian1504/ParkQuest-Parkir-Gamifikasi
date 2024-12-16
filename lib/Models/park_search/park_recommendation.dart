// To parse this JSON data, do
//
//     final parkRecommendationModel = parkRecommendationModelFromJson(jsonString);

import 'dart:convert';

ParkRecommendationModel parkRecommendationModelFromJson(String str) =>
    ParkRecommendationModel.fromJson(json.decode(str));

String parkRecommendationModelToJson(ParkRecommendationModel data) =>
    json.encode(data.toJson());

class ParkRecommendationModel {
  int id;
  int parkAreaId;
  int userId;
  int capacity;
  String image;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  ParkRecommendationModel({
    required this.id,
    required this.parkAreaId,
    required this.userId,
    required this.capacity,
    required this.image,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory ParkRecommendationModel.fromJson(Map<String, dynamic> json) =>
      ParkRecommendationModel(
        id: json["id"],
        parkAreaId: json["park_area_id"],
        userId: json["user_id"],
        capacity: json["capacity"],
        image: json["image"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "park_area_id": parkAreaId,
        "user_id": userId,
        "capacity": capacity,
        "image": image,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
      };
}

class User {
  int id;
  int roleId;
  int rankId;
  String name;
  String username;
  String email;
  dynamic emailVerifiedAt;
  dynamic avatar;
  String identityNumber;
  int totalExp;
  int coin;
  String referralCode;
  int isAdmin;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.roleId,
    required this.rankId,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.avatar,
    required this.identityNumber,
    required this.totalExp,
    required this.coin,
    required this.referralCode,
    required this.isAdmin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        rankId: json["rank_id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        avatar: json["avatar"],
        identityNumber: json["identity_number"],
        totalExp: json["total_exp"],
        coin: json["coin"],
        referralCode: json["referral_code"],
        isAdmin: json["is_admin"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "rank_id": rankId,
        "name": name,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "avatar": avatar,
        "identity_number": identityNumber,
        "total_exp": totalExp,
        "coin": coin,
        "referral_code": referralCode,
        "is_admin": isAdmin,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
