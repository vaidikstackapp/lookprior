// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.email,
    this.name,
    this.password,
    this.phoneNumber,
    this.countryCode,
    this.deviceToken,
    this.deviceType,
  });

  String? email;
  String? name;
  String? password;
  String? phoneNumber;
  String? countryCode;
  String? deviceToken;
  String? deviceType;

  factory RegisterModel.fromJson(Map json) => RegisterModel(
        email: json["email"],
        name: json["name"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        countryCode: json["countryCode"],
        deviceToken: json["deviceToken"],
        deviceType: json["deviceType"],
      );

  Map toJson() => {
        "email": email,
        "name": name,
        "password": password,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode,
        "deviceToken": deviceToken,
        "deviceType": deviceType,
      };
}
