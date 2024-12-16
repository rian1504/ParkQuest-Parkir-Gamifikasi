// To parse this JSON data, do
//
//     final surveyDetailModel = surveyDetailModelFromJson(jsonString);

import 'dart:convert';

SurveyDetailModel surveyDetailModelFromJson(String str) =>
    SurveyDetailModel.fromJson(json.decode(str));

String surveyDetailModelToJson(SurveyDetailModel data) =>
    json.encode(data.toJson());

class SurveyDetailModel {
  int id;
  int rewardId;
  String surveyName;
  String surveyVideo;
  String surveyImage;
  DateTime createdAt;
  DateTime updatedAt;
  List<Question> question;

  SurveyDetailModel({
    required this.id,
    required this.rewardId,
    required this.surveyName,
    required this.surveyVideo,
    required this.surveyImage,
    required this.createdAt,
    required this.updatedAt,
    required this.question,
  });

  factory SurveyDetailModel.fromJson(Map<String, dynamic> json) =>
      SurveyDetailModel(
        id: json["id"],
        rewardId: json["reward_id"],
        surveyName: json["survey_name"],
        surveyVideo: json["survey_video"],
        surveyImage: json["survey_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        question: List<Question>.from(
            json["question"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reward_id": rewardId,
        "survey_name": surveyName,
        "survey_video": surveyVideo,
        "survey_image": surveyImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "question": List<dynamic>.from(question.map((x) => x.toJson())),
      };
}

class Question {
  int id;
  int surveyId;
  String question;
  DateTime createdAt;
  DateTime updatedAt;

  Question({
    required this.id,
    required this.surveyId,
    required this.question,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        surveyId: json["survey_id"],
        question: json["question"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "survey_id": surveyId,
        "question": question,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
