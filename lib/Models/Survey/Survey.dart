// To parse this JSON data, do
//
//     final surveyModel = surveyModelFromJson(jsonString);

import 'dart:convert';

SurveyModel surveyModelFromJson(String str) =>
    SurveyModel.fromJson(json.decode(str));

String surveyModelToJson(SurveyModel data) => json.encode(data.toJson());

class SurveyModel {
  int id;
  int rewardId;
  String surveyName;
  String surveyVideo;
  String surveyImage;
  DateTime createdAt;
  DateTime updatedAt;

  SurveyModel({
    required this.id,
    required this.rewardId,
    required this.surveyName,
    required this.surveyVideo,
    required this.surveyImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
        id: json["id"],
        rewardId: json["reward_id"],
        surveyName: json["survey_name"],
        surveyVideo: json["survey_video"],
        surveyImage: json["survey_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reward_id": rewardId,
        "survey_name": surveyName,
        "survey_video": surveyVideo,
        "survey_image": surveyImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
