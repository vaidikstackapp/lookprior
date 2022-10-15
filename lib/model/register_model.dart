// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.success = false,
    this.message,
  });

  bool success;
  String? message;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        success: json["Success"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
      };
}
