// To parse this JSON data, do
//
//     final getBroadcastDetail = getBroadcastDetailFromJson(jsonString);

import 'dart:convert';

GetBroadcastDetailModel getBroadcastDetailModelFromJson(String str) =>
    GetBroadcastDetailModel.fromJson(json.decode(str));

String getBroadcastDetailModelToJson(GetBroadcastDetailModel data) =>
    json.encode(data.toJson());

class GetBroadcastDetailModel {
  GetBroadcastDetailModel({
    this.success = false,
    this.message,
    this.broadCastId,
    this.addDetailId,
    this.title,
    this.addType,
    this.addTypeStr,
    this.description,
    this.url,
    this.isUrl = false,
    this.latitude,
    this.longitude,
    this.amount,
    this.amountStr,
    this.state,
    this.city,
    this.stateName,
    this.cityName,
    this.location,
    this.sparePartList,
    this.userName,
    this.firstName,
    this.lastName,
    this.userId,
    this.phoneNumber,
    this.businessName,
    this.businessUrl,
    this.publicProfile = false,
    this.commercialAd,
    this.senderImagePath,
    this.image,
    this.receiverImagePath,
    this.typeId,
    this.categoryId,
    this.categoryName,
    this.subCategoryId,
    this.suSubCategoryId,
    this.subCategoryName,
    this.suSubCategoryName,
    this.totalViews,
    this.messageThreadId,
    this.isBlock = false,
    this.blockedBy,
    this.adImage,
    this.adVideo,
    this.similarAddList,
    this.isTopAd = false,
    this.isReported = false,
    this.isDeleted = false,
    this.isMyAd = false,
    this.isFavAd = false,
    this.currentUserId,
    this.hasVideoAndImageMissing = false,
    this.videoAndImageMissingErrorMessage,
    this.allowLeadGeneration = false,
    this.hasUnlimitedLead = false,
    this.totalAvailableLead,
    this.isApproveAd = false,
    this.isFeatureAd = false,
  });

  bool success;
  String? message;
  num? broadCastId;
  num? addDetailId;
  String? title;
  num? addType;
  String? addTypeStr;
  String? description;
  String? url;
  bool isUrl;
  num? latitude;
  num? longitude;
  num? amount;
  String? amountStr;
  String? state;
  String? city;
  String? stateName;
  String? cityName;
  String? location;
  List<dynamic>? sparePartList;
  String? userName;
  String? firstName;
  String? lastName;
  num? userId;
  String? phoneNumber;
  String? businessName;
  String? businessUrl;
  bool publicProfile;
  String? commercialAd;
  String? senderImagePath;
  String? image;
  String? receiverImagePath;
  num? typeId;
  num? categoryId;
  String? categoryName;
  num? subCategoryId;
  dynamic suSubCategoryId;
  String? subCategoryName;
  String? suSubCategoryName;
  num? totalViews;
  dynamic messageThreadId;
  bool isBlock;
  num? blockedBy;
  List<AdImage>? adImage;
  List<AdVideo>? adVideo;
  List<SimilarAddList>? similarAddList;
  bool isTopAd;
  bool isReported;
  bool isDeleted;
  bool isMyAd;
  bool isFavAd;
  num? currentUserId;
  bool hasVideoAndImageMissing;
  String? videoAndImageMissingErrorMessage;
  bool allowLeadGeneration;
  bool hasUnlimitedLead;
  dynamic totalAvailableLead;
  bool isApproveAd;
  bool isFeatureAd;

  factory GetBroadcastDetailModel.fromJson(Map<String, dynamic> json) =>
      GetBroadcastDetailModel(
        success: json["Success"],
        message: json["Message"],
        broadCastId: json["BroadCastId"],
        addDetailId: json["AddDetailId"],
        title: json["Title"],
        addType: json["AddType"],
        addTypeStr: json["AddTypeStr"],
        description: json["Description"],
        url: json["Url"],
        isUrl: json["IsUrl"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        amount: json["Amount"].toDouble(),
        amountStr: json["AmountStr"],
        state: json["State"],
        city: json["City"],
        stateName: json["StateName"],
        cityName: json["CityName"],
        location: json["Location"],
        sparePartList: List<dynamic>.from(json["SparePartList"].map((x) => x)),
        userName: json["UserName"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        userId: json["UserId"],
        phoneNumber: json["PhoneNumber"],
        businessName: json["BusinessName"],
        businessUrl: json["BusinessUrl"],
        publicProfile: json["PublicProfile"],
        commercialAd: json["CommercialAd"],
        senderImagePath: json["SenderImagePath"],
        image: json["Image"],
        receiverImagePath: json["ReceiverImagePath"],
        typeId: json["TypeId"],
        categoryId: json["CategoryId"],
        categoryName: json["CategoryName"],
        subCategoryId: json["SubCategoryId"],
        suSubCategoryId: json["SuSubCategoryId"],
        subCategoryName: json["SubCategoryName"],
        suSubCategoryName: json["SuSubCategoryName"],
        totalViews: json["TotalViews"],
        messageThreadId: json["MessageThreadId"],
        isBlock: json["IsBlock"],
        blockedBy: json["BlockedBy"],
        adImage:
            List<AdImage>.from(json["AdImage"].map((x) => AdImage.fromJson(x))),
        adVideo:
            List<AdVideo>.from(json["AdVideo"].map((x) => AdVideo.fromJson(x))),
        similarAddList: List<SimilarAddList>.from(
            json["SimilarAddList"].map((x) => SimilarAddList.fromJson(x))),
        isTopAd: json["IsTopAd"],
        isReported: json["IsReported"],
        isDeleted: json["IsDeleted"],
        isMyAd: json["IsMyAd"],
        isFavAd: json["IsFavAd"],
        currentUserId: json["CurrentUserId"],
        hasVideoAndImageMissing: json["HasVideoAndImageMissing"],
        videoAndImageMissingErrorMessage:
            json["VideoAndImageMissingErrorMessage"],
        allowLeadGeneration: json["AllowLeadGeneration"],
        hasUnlimitedLead: json["HasUnlimitedLead"],
        totalAvailableLead: json["TotalAvailableLead"],
        isApproveAd: json["IsApproveAd"],
        isFeatureAd: json["IsFeatureAd"],
      );

  Map<String, dynamic> toJson() => {
        "Success": success,
        "Message": message,
        "BroadCastId": broadCastId,
        "AddDetailId": addDetailId,
        "Title": title,
        "AddType": addType,
        "AddTypeStr": addTypeStr,
        "Description": description,
        "Url": url,
        "IsUrl": isUrl,
        "Latitude": latitude,
        "Longitude": longitude,
        "Amount": amount,
        "AmountStr": amountStr,
        "State": state,
        "City": city,
        "StateName": stateName,
        "CityName": cityName,
        "Location": location,
        "SparePartList": List<dynamic>.from(sparePartList!.map((x) => x)),
        "UserName": userName,
        "FirstName": firstName,
        "LastName": lastName,
        "UserId": userId,
        "PhoneNumber": phoneNumber,
        "BusinessName": businessName,
        "BusinessUrl": businessUrl,
        "PublicProfile": publicProfile,
        "CommercialAd": commercialAd,
        "SenderImagePath": senderImagePath,
        "Image": image,
        "ReceiverImagePath": receiverImagePath,
        "TypeId": typeId,
        "CategoryId": categoryId,
        "CategoryName": categoryName,
        "SubCategoryId": subCategoryId,
        "SuSubCategoryId": suSubCategoryId,
        "SubCategoryName": subCategoryName,
        "SuSubCategoryName": suSubCategoryName,
        "TotalViews": totalViews,
        "MessageThreadId": messageThreadId,
        "IsBlock": isBlock,
        "BlockedBy": blockedBy,
        "AdImage": List<dynamic>.from(adImage!.map((x) => x.toJson())),
        "AdVideo": List<dynamic>.from(adVideo!.map((x) => x.toJson())),
        "SimilarAddList":
            List<dynamic>.from(similarAddList!.map((x) => x.toJson())),
        "IsTopAd": isTopAd,
        "IsReported": isReported,
        "IsDeleted": isDeleted,
        "IsMyAd": isMyAd,
        "IsFavAd": isFavAd,
        "CurrentUserId": currentUserId,
        "HasVideoAndImageMissing": hasVideoAndImageMissing,
        "VideoAndImageMissingErrorMessage": videoAndImageMissingErrorMessage,
        "AllowLeadGeneration": allowLeadGeneration,
        "HasUnlimitedLead": hasUnlimitedLead,
        "TotalAvailableLead": totalAvailableLead,
        "IsApproveAd": isApproveAd,
        "IsFeatureAd": isFeatureAd,
      };
}

class AdImage {
  AdImage({
    this.imageId,
    this.image,
    this.adImageThumb,
    this.size,
    this.addDetailId,
  });

  num? imageId;
  String? image;
  String? adImageThumb;
  String? size;
  num? addDetailId;

  factory AdImage.fromJson(Map<String, dynamic> json) => AdImage(
        imageId: json["ImageId"],
        image: json["Image"],
        adImageThumb: json["AdImageThumb"],
        size: json["Size"],
        addDetailId: json["AddDetailId"],
      );

  Map<String, dynamic> toJson() => {
        "ImageId": imageId,
        "Image": image,
        "AdImageThumb": adImageThumb,
        "Size": size,
        "AddDetailId": addDetailId,
      };
}

class AdVideo {
  AdVideo({
    this.videoId,
    this.video,
    this.videoThumb,
    this.size,
    this.newSize,
    this.videoDuration,
    this.addDetailId,
  });

  num? videoId;
  String? video;
  String? videoThumb;
  String? size;
  dynamic newSize;
  num? videoDuration;
  num? addDetailId;

  factory AdVideo.fromJson(Map<String, dynamic> json) => AdVideo(
        videoId: json["VideoId"],
        video: json["Video"],
        videoThumb: json["VideoThumb"],
        size: json["Size"],
        newSize: json["NewSize"],
        videoDuration: json["VideoDuration"],
        addDetailId: json["AddDetailId"],
      );

  Map<String, dynamic> toJson() => {
        "VideoId": videoId,
        "Video": video,
        "VideoThumb": videoThumb,
        "Size": size,
        "NewSize": newSize,
        "VideoDuration": videoDuration,
        "AddDetailId": addDetailId,
      };
}

class SimilarAddList {
  SimilarAddList({
    this.broadCastId,
    this.title,
    this.isMyAd = false,
    this.isFavAd = false,
    this.amount,
    this.adImage,
    this.adImageThumb,
    this.adVideo,
    this.adVideoThumb,
    this.isDeleted = false,
    this.isApproved = false,
    this.isFeatureAd = false,
    this.categoryId,
    this.subCategoryId,
    this.categoryName,
    this.subCategoryName,
    this.fullAddress,
  });

  num? broadCastId;
  String? title;
  bool isMyAd;
  bool isFavAd;
  num? amount;
  String? adImage;
  String? adImageThumb;
  String? adVideo;
  String? adVideoThumb;
  bool isDeleted;
  bool isApproved;
  bool isFeatureAd;
  num? categoryId;
  num? subCategoryId;
  String? categoryName;
  String? subCategoryName;
  String? fullAddress;

  factory SimilarAddList.fromJson(Map<String, dynamic> json) => SimilarAddList(
        broadCastId: json["BroadCastId"],
        title: json["Title"],
        isMyAd: json["IsMyAd"],
        isFavAd: json["IsFavAd"],
        amount: json["Amount"],
        adImage: json["AdImage"],
        adImageThumb: json["AdImageThumb"],
        adVideo: json["AdVideo"],
        adVideoThumb: json["AdVideoThumb"],
        isDeleted: json["IsDeleted"],
        isApproved: json["IsApproved"],
        isFeatureAd: json["IsFeatureAd"],
        categoryId: json["CategoryId"],
        subCategoryId: json["SubCategoryId"],
        categoryName: json["CategoryName"],
        subCategoryName: json["SubCategoryName"],
        fullAddress: json["FullAddress"],
      );

  Map<String, dynamic> toJson() => {
        "BroadCastId": broadCastId,
        "Title": title,
        "IsMyAd": isMyAd,
        "IsFavAd": isFavAd,
        "Amount": amount,
        "AdImage": adImage,
        "AdImageThumb": adImageThumb,
        "AdVideo": adVideo,
        "AdVideoThumb": adVideoThumb,
        "IsDeleted": isDeleted,
        "IsApproved": isApproved,
        "IsFeatureAd": isFeatureAd,
        "CategoryId": categoryId,
        "SubCategoryId": subCategoryId,
        "CategoryName": categoryName,
        "SubCategoryName": subCategoryName,
        "FullAddress": fullAddress,
      };
}
