// To parse this JSON data, do
//
//     final getFilteredAds = getFilteredAdsFromJson(jsonString);

import 'dart:convert';

GetFilteredAdsModel getFilteredAdsModelFromJson(String str) =>
    GetFilteredAdsModel.fromJson(json.decode(str));

String getFilteredAdsModelToJson(GetFilteredAdsModel data) =>
    json.encode(data.toJson());

class GetFilteredAdsModel {
  GetFilteredAdsModel({
    this.success = false,
    this.message,
    this.pageNo,
    this.isNextPage = false,
    this.pageSize,
    this.totalRecords,
    this.filteredAddList,
  });

  bool success;
  String? message;
  num? pageNo;
  bool isNextPage;
  num? pageSize;
  num? totalRecords;
  List<FilteredAddList>? filteredAddList;

  factory GetFilteredAdsModel.fromJson(Map<String, dynamic> json) =>
      GetFilteredAdsModel(
        success: json["Success"],
        message: json["Message"],
        pageNo: json["pageNo"],
        isNextPage: json["IsNextPage"],
        pageSize: json["pageSize"],
        totalRecords: json["TotalRecords"],
        filteredAddList: List<FilteredAddList>.from(
            json["FilteredAddList"].map((x) => FilteredAddList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
        "pageNo": pageNo,
        "IsNextPage": isNextPage,
        "pageSize": pageSize,
        "TotalRecords": totalRecords,
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
    this.isReviewed,
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
  String? city;
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
  dynamic description;
  bool isOwner;
  bool isTopAdd;
  bool isMyAd;
  num? orderByDistance;
  num? randomSort;
  bool isDeleted;
  dynamic isReviewed;
  bool isApproved;
  num? latitude;
  num? longitude;
  dynamic totalExposureDays;
  num? perDayExposurePrice;
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
        orderByDistance: json["OrderByDistance"].toDouble(),
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
