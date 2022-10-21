// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) =>
    UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) =>
    json.encode(data.toJson());

class UpdateProfileModel {
  UpdateProfileModel({
    this.success = false,
    this.message,
    this.userId,
    this.userName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.imagePath,
    this.userTypeId,
    this.website,
    this.publicProfile = false,
    this.fullAddress,
    this.isEmailChanged = false,
    this.ispublicemail = false,
    this.countryCode,
    this.latitude,
    this.longitude,
  });

  bool success;
  String? message;
  num? userId;
  String? userName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? imagePath;
  num? userTypeId;
  String? website;
  bool publicProfile;
  String? fullAddress;
  bool isEmailChanged;
  bool ispublicemail;
  String? countryCode;
  num? latitude;
  num? longitude;

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
        success: json["Success"],
        message: json["Message"],
        userId: json["UserId"],
        userName: json["UserName"],
        lastName: json["LastName"],
        email: json["Email"],
        phoneNumber: json["PhoneNumber"],
        imagePath: json["ImagePath"],
        userTypeId: json["UserTypeId"],
        website: json["Website"],
        publicProfile: json["PublicProfile"],
        fullAddress: json["FullAddress"],
        isEmailChanged: json["IsEmailChanged"],
        ispublicemail: json["ispublicemail"],
        countryCode: json["CountryCode"],
        latitude: json["Latitude"].toDouble(),
        longitude: json["Longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
        "UserId": userId,
        "UserName": userName,
        "LastName": lastName,
        "Email": email,
        "PhoneNumber": phoneNumber,
        "ImagePath": imagePath,
        "UserTypeId": userTypeId,
        "Website": website,
        "PublicProfile": publicProfile,
        "FullAddress": fullAddress,
        "IsEmailChanged": isEmailChanged,
        "ispublicemail": ispublicemail,
        "CountryCode": countryCode,
        "Latitude": latitude,
        "Longitude": longitude,
      };
}
