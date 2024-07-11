// To parse this JSON data, do
//
//     final getFurnitureResponseModel = getFurnitureResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetFurnitureResponseModel> getFurnitureResponseModelFromJson(String str) =>
    List<GetFurnitureResponseModel>.from(
        json.decode(str).map((x) => GetFurnitureResponseModel.fromJson(x)));

String getFurnitureResponseModelToJson(List<GetFurnitureResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFurnitureResponseModel {
  int? id;
  List<FurnitureImageList>? furnitureImageList;
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
  String? createdOn;
  int? modifiedBy;
  String? modifiedOn;
  String? tag;
  String? tableRefGuid;

  GetFurnitureResponseModel({
    this.id,
    this.furnitureImageList,
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

  factory GetFurnitureResponseModel.fromJson(Map<String, dynamic> json) =>
      GetFurnitureResponseModel(
        id: json["id"],
        furnitureImageList: json["furnitureImageList"] == null
            ? []
            : List<FurnitureImageList>.from(json["furnitureImageList"]!
                .map((x) => FurnitureImageList.fromJson(x))),
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
        createdOn: json["createdOn"],
        modifiedBy: json["modifiedBy"],
        modifiedOn: json["modifiedOn"],
        tag: json["tag"],
        tableRefGuid: json["tableRefGuid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "furnitureImageList": furnitureImageList == null
            ? []
            : List<dynamic>.from(furnitureImageList!.map((x) => x.toJson())),
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
        "createdOn": createdOn,
        "modifiedBy": modifiedBy,
        "modifiedOn": modifiedOn,
        "tag": tag,
        "tableRefGuid": tableRefGuid,
      };
}

class FurnitureImageList {
  int? furnituresId;
  int? id;
  String? imageId;
  String? imageUrl;

  FurnitureImageList({
    this.furnituresId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory FurnitureImageList.fromJson(Map<String, dynamic> json) =>
      FurnitureImageList(
        furnituresId: json["furnituresId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "furnituresId": furnituresId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
