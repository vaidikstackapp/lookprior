// To parse this JSON data, do
//
//     final faceBookModel = faceBookModelFromJson(jsonString);

import 'dart:convert';

FaceBookModel faceBookModelFromJson(String str) =>
    FaceBookModel.fromJson(json.decode(str));

String faceBookModelToJson(FaceBookModel data) => json.encode(data.toJson());

class FaceBookModel {
  FaceBookModel({
    this.name,
    this.picture,
    this.id,
  });

  String? name;
  Picture? picture;
  String? id;

  factory FaceBookModel.fromJson(Map<String, dynamic> json) => FaceBookModel(
        name: json["name"],
        picture: Picture.fromJson(json["picture"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "picture": picture!.toJson(),
        "id": id,
      };
}

class Picture {
  Picture({
    this.data,
  });

  Data? data;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.height,
    this.isSilhouette = false,
    this.url,
    this.width,
  });

  num? height;
  bool isSilhouette;
  String? url;
  num? width;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        height: json["height"],
        isSilhouette: json["is_silhouette"],
        url: json["url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "is_silhouette": isSilhouette,
        "url": url,
        "width": width,
      };
}
