// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.userId,
    this.success = false,
    this.message,
    this.userName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.imagePath,
    this.userTypeId,
    this.businessName,
    this.website,
    this.publicProfile = false,
    this.fullAddress,
    this.zipcode,
    this.countryCode,
    this.totalImagesAndVideo,
    this.ispublicemail = false,
    this.isEmailFieldDisabled = false,
    this.averageRating,
    this.totalReviews,
    this.totalFollowers,
    this.totalFollowing,
    this.totalSuggested,
    this.filteredAddList,
  });

  num? userId;
  bool success;
  String? message;
  String? userName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? imagePath;
  num? userTypeId;
  String? businessName;
  String? website;
  bool publicProfile;
  String? fullAddress;
  String? zipcode;
  String? countryCode;
  num? totalImagesAndVideo;
  bool ispublicemail;
  bool isEmailFieldDisabled;
  num? averageRating;
  num? totalReviews;
  num? totalFollowers;
  num? totalFollowing;
  num? totalSuggested;
  List<dynamic>? filteredAddList;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["UserId"],
        success: json["Success"],
        message: json["Message"],
        userName: json["UserName"],
        lastName: json["LastName"],
        email: json["Email"],
        phoneNumber: json["PhoneNumber"],
        imagePath: json["ImagePath"],
        userTypeId: json["UserTypeId"],
        businessName: json["BusinessName"],
        website: json["Website"],
        publicProfile: json["PublicProfile"],
        fullAddress: json["FullAddress"],
        zipcode: json["Zipcode"],
        countryCode: json["CountryCode"],
        totalImagesAndVideo: json["TotalImagesAndVideo"],
        ispublicemail: json["ispublicemail"],
        isEmailFieldDisabled: json["IsEmailFieldDisabled"],
        averageRating: json["AverageRating"],
        totalReviews: json["TotalReviews"],
        totalFollowers: json["TotalFollowers"],
        totalFollowing: json["TotalFollowing"],
        totalSuggested: json["TotalSuggested"],
        filteredAddList:
            List<dynamic>.from(json["FilteredAddList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "Success": success,
        "Message": message,
        "UserName": userName,
        "LastName": lastName,
        "Email": email,
        "PhoneNumber": phoneNumber,
        "ImagePath": imagePath,
        "UserTypeId": userTypeId,
        "BusinessName": businessName,
        "Website": website,
        "PublicProfile": publicProfile,
        "FullAddress": fullAddress,
        "Zipcode": zipcode,
        "CountryCode": countryCode,
        "TotalImagesAndVideo": totalImagesAndVideo,
        "ispublicemail": ispublicemail,
        "IsEmailFieldDisabled": isEmailFieldDisabled,
        "AverageRating": averageRating,
        "TotalReviews": totalReviews,
        "TotalFollowers": totalFollowers,
        "TotalFollowing": totalFollowing,
        "TotalSuggested": totalSuggested,
        "FilteredAddList": List<dynamic>.from(filteredAddList!.map((x) => x)),
      };
}
