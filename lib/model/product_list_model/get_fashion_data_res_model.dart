// To parse this JSON data, do
//
//     final getAllFashionDataResponseModel = getAllFashionDataResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllFashionDataResponseModel> getAllFashionDataResponseModelFromJson(
        String str) =>
    List<GetAllFashionDataResponseModel>.from(json
        .decode(str)
        .map((x) => GetAllFashionDataResponseModel.fromJson(x)));

String getAllFashionDataResponseModelToJson(
        List<GetAllFashionDataResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllFashionDataResponseModel {
  int? id;
  List<FashionImageList>? fashionImageList;
  int? subCategoryId;
  int? categoryId;
  String? title;
  String? discription;
  int? price;
  String? pincode;
  String? state;
  String? city;
  String? nearBy;
  String? name;
  String? mobile;
  bool? isPremium;
  bool? isActive;
  bool? isVerified;
  int? createdBy;
  DateTime? createdOn;
  int? modifiedBy;
  DateTime? modifiedOn;
  dynamic tag;
  String? tableRefGuid;

  GetAllFashionDataResponseModel({
    this.id,
    this.fashionImageList,
    this.subCategoryId,
    this.categoryId,
    this.title,
    this.discription,
    this.price,
    this.pincode,
    this.state,
    this.city,
    this.nearBy,
    this.name,
    this.mobile,
    this.isPremium,
    this.isActive,
    this.isVerified,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
    this.tag,
    this.tableRefGuid,
  });

  factory GetAllFashionDataResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllFashionDataResponseModel(
        id: json["id"],
        fashionImageList: json["fashionImageList"] == null
            ? []
            : List<FashionImageList>.from(json["fashionImageList"]!
                .map((x) => FashionImageList.fromJson(x))),
        subCategoryId: json["subCategoryId"],
        categoryId: json["categoryId"],
        title: json["title"],
        discription: json["discription"],
        price: json["price"],
        pincode: json["pincode"],
        state: json["state"],
        city: json["city"],
        nearBy: json["nearBy"],
        name: json["name"],
        mobile: json["mobile"],
        isPremium: json["isPremium"],
        isActive: json["isActive"],
        isVerified: json["isVerified"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"] == null
            ? null
            : DateTime.parse(json["createdOn"]),
        modifiedBy: json["modifiedBy"],
        modifiedOn: json["modifiedOn"] == null
            ? null
            : DateTime.parse(json["modifiedOn"]),
        tag: json["tag"],
        tableRefGuid: json["tableRefGuid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fashionImageList": fashionImageList == null
            ? []
            : List<dynamic>.from(fashionImageList!.map((x) => x.toJson())),
        "subCategoryId": subCategoryId,
        "categoryId": categoryId,
        "title": title,
        "discription": discription,
        "price": price,
        "pincode": pincode,
        "state": state,
        "city": city,
        "nearBy": nearBy,
        "name": name,
        "mobile": mobile,
        "isPremium": isPremium,
        "isActive": isActive,
        "isVerified": isVerified,
        "createdBy": createdBy,
        "createdOn": createdOn?.toIso8601String(),
        "modifiedBy": modifiedBy,
        "modifiedOn": modifiedOn?.toIso8601String(),
        "tag": tag,
        "tableRefGuid": tableRefGuid,
      };
}

class FashionImageList {
  int? fashionId;
  int? id;
  String? imageId;
  String? imageUrl;

  FashionImageList({
    this.fashionId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory FashionImageList.fromJson(Map<String, dynamic> json) =>
      FashionImageList(
        fashionId: json["fashionId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "fashionId": fashionId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
