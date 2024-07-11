// To parse this JSON data, do
//
//     final getAllGadgetResponseModel = getAllGadgetResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllGadgetResponseModel> getAllGadgetResponseModelFromJson(String str) =>
    List<GetAllGadgetResponseModel>.from(
        json.decode(str).map((x) => GetAllGadgetResponseModel.fromJson(x)));

String getAllGadgetResponseModelToJson(List<GetAllGadgetResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllGadgetResponseModel {
  int? id;
  List<GadgetImageList>? gadgetImageList;
  int? subCategoryId;
  int? mobileBrandId;
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

  GetAllGadgetResponseModel({
    this.id,
    this.gadgetImageList,
    this.subCategoryId,
    this.mobileBrandId,
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

  factory GetAllGadgetResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllGadgetResponseModel(
        id: json["id"],
        gadgetImageList: json["gadgetImageList"] == null
            ? []
            : List<GadgetImageList>.from(json["gadgetImageList"]!
                .map((x) => GadgetImageList.fromJson(x))),
        subCategoryId: json["subCategoryId"],
        mobileBrandId: json["mobileBrandId"],
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
        "gadgetImageList": gadgetImageList == null
            ? []
            : List<dynamic>.from(gadgetImageList!.map((x) => x.toJson())),
        "subCategoryId": subCategoryId,
        "mobileBrandId": mobileBrandId,
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

class GadgetImageList {
  int? gadgetsId;
  int? id;
  String? imageId;
  String? imageUrl;

  GadgetImageList({
    this.gadgetsId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory GadgetImageList.fromJson(Map<String, dynamic> json) =>
      GadgetImageList(
        gadgetsId: json["gadgetsId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "gadgetsId": gadgetsId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
