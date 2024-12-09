// To parse this JSON data, do
//
//     final leaderboardModel = leaderboardModelFromJson(jsonString);

import 'dart:convert';

LeaderboardModel leaderboardModelFromJson(String str) =>
    LeaderboardModel.fromJson(json.decode(str));

String leaderboardModelToJson(LeaderboardModel data) =>
    json.encode(data.toJson());

class LeaderboardModel {
  int id;
  int userId;
  int rankId;
  DateTime startDate;
  DateTime createdAt;
  DateTime updatedAt;
  int roleId;
  String name;
  String username;
  String email;
  dynamic emailVerifiedAt;
  String password;
  dynamic avatar;
  String identityNumber;
  int totalExp;
  int coin;
  String referralCode;
  int isAdmin;
  dynamic rememberToken;
  Rank rank;

  LeaderboardModel({
    required this.id,
    required this.userId,
    required this.rankId,
    required this.startDate,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.name,
    required this.username,
    required this.email,
    required this.emailVerifiedAt,
    required this.password,
    required this.avatar,
    required this.identityNumber,
    required this.totalExp,
    required this.coin,
    required this.referralCode,
    required this.isAdmin,
    required this.rememberToken,
    required this.rank,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) =>
      LeaderboardModel(
        id: json["id"],
        userId: json["user_id"],
        rankId: json["rank_id"],
        startDate: DateTime.parse(json["start_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        roleId: json["role_id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        avatar: json["avatar"],
        identityNumber: json["identity_number"],
        totalExp: json["total_exp"],
        coin: json["coin"],
        referralCode: json["referral_code"],
        isAdmin: json["is_admin"],
        rememberToken: json["remember_token"],
        rank: Rank.fromJson(json["rank"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "rank_id": rankId,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "role_id": roleId,
        "name": name,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "password": password,
        "avatar": avatar,
        "identity_number": identityNumber,
        "total_exp": totalExp,
        "coin": coin,
        "referral_code": referralCode,
        "is_admin": isAdmin,
        "remember_token": rememberToken,
        "rank": rank.toJson(),
      };
}

class Rank {
  int? id;
  String? rankName;
  int? expRequired;
  DateTime? createdAt;
  DateTime? updatedAt;

  Rank({
    required this.id,
    required this.rankName,
    required this.expRequired,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Rank.fromJson(Map<String, dynamic> json) => Rank(
        id: json["id"],
        rankName: json["rank_name"],
        expRequired: json["exp_required"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rank_name": rankName,
        "exp_required": expRequired,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
