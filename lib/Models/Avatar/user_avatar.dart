// To parse this JSON data, do
//
//     final userAvatarModel = userAvatarModelFromJson(jsonString);

import 'dart:convert';

UserAvatarModel userAvatarModelFromJson(String str) =>
    UserAvatarModel.fromJson(json.decode(str));

String userAvatarModelToJson(UserAvatarModel data) =>
    json.encode(data.toJson());

class UserAvatarModel {
  int id;
  int userId;
  int avatarId;
  int isEquipped;
  DateTime createdAt;
  DateTime updatedAt;
  int rarityId;
  String avatarName;
  String avatarDescription;
  String avatarImage;
  String rarityName;
  int price;

  UserAvatarModel({
    required this.id,
    required this.userId,
    required this.avatarId,
    required this.isEquipped,
    required this.createdAt,
    required this.updatedAt,
    required this.rarityId,
    required this.avatarName,
    required this.avatarDescription,
    required this.avatarImage,
    required this.rarityName,
    required this.price,
  });

  factory UserAvatarModel.fromJson(Map<String, dynamic> json) =>
      UserAvatarModel(
        id: json["id"],
        userId: json["user_id"],
        avatarId: json["avatar_id"],
        isEquipped: json["is_equipped"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        rarityId: json["rarity_id"],
        avatarName: json["avatar_name"],
        avatarDescription: json["avatar_description"],
        avatarImage: json["avatar_image"],
        rarityName: json["rarity_name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "avatar_id": avatarId,
        "is_equipped": isEquipped,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "rarity_id": rarityId,
        "avatar_name": avatarName,
        "avatar_description": avatarDescription,
        "avatar_image": avatarImage,
        "rarity_name": rarityName,
        "price": price,
      };
}
