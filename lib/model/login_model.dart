// To parse this JSON data, do
//
//     final logInModel = logInModelFromJson(jsonString);

import 'dart:convert';

LogInModel logInModelFromJson(String str) =>
    LogInModel.fromJson(json.decode(str));

String logInModelToJson(LogInModel data) => json.encode(data.toJson());

class LogInModel {
  LogInModel({
    this.success = false,
    this.message,
    this.userId,
    this.isEditable = false,
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  bool success;
  String? message;
  num? userId;
  bool isEditable;
  String? accessToken;
  String? tokenType;
  num? expiresIn;

  factory LogInModel.fromJson(Map<String, dynamic> json) => LogInModel(
        success: json["Success"],
        message: json["Message"],
        userId: json["UserId"],
        isEditable: json["IsEditable"],
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
        "UserId": userId,
        "IsEditable": isEditable,
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}
