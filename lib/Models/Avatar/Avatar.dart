// To parse this JSON data, do
//
//     final avatarModel = avatarModelFromJson(jsonString);

import 'dart:convert';

AvatarModel avatarModelFromJson(String str) =>
    AvatarModel.fromJson(json.decode(str));

String avatarModelToJson(AvatarModel data) => json.encode(data.toJson());

class AvatarModel {
  int id;
  String rarityName;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  int rarityId;
  String avatarName;
  String avatarDescription;
  String avatarImage;

  AvatarModel({
    required this.id,
    required this.rarityName,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.rarityId,
    required this.avatarName,
    required this.avatarDescription,
    required this.avatarImage,
  });

  factory AvatarModel.fromJson(Map<String, dynamic> json) => AvatarModel(
        id: json["id"],
        rarityName: json["rarity_name"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rarityId: json["rarity_id"],
        avatarName: json["avatar_name"],
        avatarDescription: json["avatar_description"],
        avatarImage: json["avatar_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rarity_name": rarityName,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rarity_id": rarityId,
        "avatar_name": avatarName,
        "avatar_description": avatarDescription,
        "avatar_image": avatarImage,
      };
}
