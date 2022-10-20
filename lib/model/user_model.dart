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
  List<FilteredAddList>? filteredAddList;

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
        filteredAddList: List<FilteredAddList>.from(
            json["FilteredAddList"].map((x) => FilteredAddList.fromJson(x))),
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
        "FilteredAddList":
            List<dynamic>.from(filteredAddList!.map((x) => x.toJson())),
      };
}

class FilteredAddList {
  FilteredAddList({
    this.broadCastId,
    this.userId,
    this.adDetailId,
    this.title,
    this.fullAddress,
    this.state,
    this.city,
    this.stateName,
    this.cityName,
    this.amount,
    this.amountStr,
    this.adImage,
    this.adImageThumb,
    this.adVideo,
    this.adVideoThumb,
    this.isLiked = false,
    this.isFavAd = false,
    this.noOfViews,
    this.description,
    this.isOwner = false,
    this.isTopAdd = false,
    this.isMyAd = false,
    this.orderByDistance,
    this.randomSort,
    this.isDeleted = false,
    this.isReviewed = false,
    this.isApproved = false,
    this.latitude,
    this.longitude,
    this.totalExposureDays,
    this.perDayExposurePrice,
    this.isFeatureAd = false,
    this.hasOnlyVideo = false,
    this.categoryId,
    this.subCategoryId,
    this.categoryName,
    this.subCategoryName,
  });

  num? broadCastId;
  num? userId;
  num? adDetailId;
  String? title;
  String? fullAddress;
  String? state;
  dynamic city;
  String? stateName;
  String? cityName;
  num? amount;
  String? amountStr;
  String? adImage;
  String? adImageThumb;
  String? adVideo;
  String? adVideoThumb;
  bool isLiked;
  bool isFavAd;
  num? noOfViews;
  String? description;
  bool isOwner;
  bool isTopAdd;
  bool isMyAd;
  dynamic orderByDistance;
  num? randomSort;
  bool isDeleted;
  bool isReviewed;
  bool isApproved;
  num? latitude;
  num? longitude;
  dynamic totalExposureDays;
  dynamic perDayExposurePrice;
  bool isFeatureAd;
  bool hasOnlyVideo;
  num? categoryId;
  num? subCategoryId;
  String? categoryName;
  String? subCategoryName;

  factory FilteredAddList.fromJson(Map<String, dynamic> json) =>
      FilteredAddList(
        broadCastId: json["BroadCastId"],
        userId: json["UserId"],
        adDetailId: json["AdDetailId"],
        title: json["Title"],
        fullAddress: json["FullAddress"],
        state: json["State"],
        city: json["City"],
        stateName: json["StateName"],
        cityName: json["CityName"],
        amount: json["Amount"].toDouble(),
        amountStr: json["AmountStr"],
        adImage: json["AdImage"],
        adImageThumb: json["AdImageThumb"],
        adVideo: json["AdVideo"],
        adVideoThumb: json["AdVideoThumb"],
        isLiked: json["IsLiked"],
        isFavAd: json["IsFavAd"],
        noOfViews: json["NoOfViews"],
        description: json["Description"],
        isOwner: json["IsOwner"],
        isTopAdd: json["IsTopAdd"],
        isMyAd: json["IsMyAd"],
        orderByDistance: json["OrderByDistance"],
        randomSort: json["RandomSort"],
        isDeleted: json["IsDeleted"],
        isReviewed: json["IsReviewed"],
        isApproved: json["IsApproved"],
        latitude: json["Latitude"].toDouble(),
        longitude: json["Longitude"].toDouble(),
        totalExposureDays: json["TotalExposureDays"],
        perDayExposurePrice: json["PerDayExposurePrice"],
        isFeatureAd: json["IsFeatureAd"],
        hasOnlyVideo: json["HasOnlyVideo"],
        categoryId: json["CategoryId"],
        subCategoryId: json["SubCategoryId"],
        categoryName: json["CategoryName"],
        subCategoryName: json["SubCategoryName"],
      );

  Map<String, dynamic> toJson() => {
        "BroadCastId": broadCastId,
        "UserId": userId,
        "AdDetailId": adDetailId,
        "Title": title,
        "FullAddress": fullAddress,
        "State": state,
        "City": city,
        "StateName": stateName,
        "CityName": cityName,
        "Amount": amount,
        "AmountStr": amountStr,
        "AdImage": adImage,
        "AdImageThumb": adImageThumb,
        "AdVideo": adVideo,
        "AdVideoThumb": adVideoThumb,
        "IsLiked": isLiked,
        "IsFavAd": isFavAd,
        "NoOfViews": noOfViews,
        "Description": description,
        "IsOwner": isOwner,
        "IsTopAdd": isTopAdd,
        "IsMyAd": isMyAd,
        "OrderByDistance": orderByDistance,
        "RandomSort": randomSort,
        "IsDeleted": isDeleted,
        "IsReviewed": isReviewed,
        "IsApproved": isApproved,
        "Latitude": latitude,
        "Longitude": longitude,
        "TotalExposureDays": totalExposureDays,
        "PerDayExposurePrice": perDayExposurePrice,
        "IsFeatureAd": isFeatureAd,
        "HasOnlyVideo": hasOnlyVideo,
        "CategoryId": categoryId,
        "SubCategoryId": subCategoryId,
        "CategoryName": categoryName,
        "SubCategoryName": subCategoryName,
      };
}
