// To parse this JSON data, do
//
//     final avatarDetailModel = avatarDetailModelFromJson(jsonString);

import 'dart:convert';

AvatarDetailModel avatarDetailModelFromJson(String str) =>
    AvatarDetailModel.fromJson(json.decode(str));

String avatarDetailModelToJson(AvatarDetailModel data) =>
    json.encode(data.toJson());

class AvatarDetailModel {
  int id;
  int rarityId;
  String avatarName;
  String avatarDescription;
  String avatarImage;
  DateTime createdAt;
  DateTime updatedAt;
  Rarity rarity;

  AvatarDetailModel({
    required this.id,
    required this.rarityId,
    required this.avatarName,
    required this.avatarDescription,
    required this.avatarImage,
    required this.createdAt,
    required this.updatedAt,
    required this.rarity,
  });

  factory AvatarDetailModel.fromJson(Map<String, dynamic> json) =>
      AvatarDetailModel(
        id: json["id"],
        rarityId: json["rarity_id"],
        avatarName: json["avatar_name"],
        avatarDescription: json["avatar_description"],
        avatarImage: json["avatar_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rarity: Rarity.fromJson(json["rarity"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rarity_id": rarityId,
        "avatar_name": avatarName,
        "avatar_description": avatarDescription,
        "avatar_image": avatarImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rarity": rarity.toJson(),
      };
}

class Rarity {
  int id;
  String rarityName;
  int price;
  DateTime createdAt;
  DateTime updatedAt;

  Rarity({
    required this.id,
    required this.rarityName,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Rarity.fromJson(Map<String, dynamic> json) => Rarity(
        id: json["id"],
        rarityName: json["rarity_name"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rarity_name": rarityName,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
