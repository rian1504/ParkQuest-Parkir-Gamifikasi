// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  int roleId;
  int rankId;
  String name;
  String username;
  String email;
  dynamic emailVerifiedAt;
  String avatar;
  String identityNumber;
  int totalExp;
  int coin;
  String referralCode;
  int isAdmin;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  String agencyCompany;
  String position;

  UserModel({
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
    required this.userId,
    required this.agencyCompany,
    required this.position,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
        userId: json["user_id"],
        agencyCompany: json["agency/company"],
        position: json["position"],
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
        "user_id": userId,
        "agency/company": agencyCompany,
        "position": position,
      };
}
