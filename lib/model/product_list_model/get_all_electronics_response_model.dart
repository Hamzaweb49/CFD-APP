// To parse this JSON data, do
//
//     final getAllElectronicsResponseModel = getAllElectronicsResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllElectronicsResponseModel> getAllElectronicsResponseModelFromJson(
        String str) =>
    List<GetAllElectronicsResponseModel>.from(json
        .decode(str)
        .map((x) => GetAllElectronicsResponseModel.fromJson(x)));

String getAllElectronicsResponseModelToJson(
        List<GetAllElectronicsResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllElectronicsResponseModel {
  int? id;
  List<ElectronicApplianceImageList>? electronicApplianceImageList;
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

  GetAllElectronicsResponseModel({
    this.id,
    this.electronicApplianceImageList,
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

  factory GetAllElectronicsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllElectronicsResponseModel(
        id: json["id"],
        electronicApplianceImageList:
            json["electronicApplianceImageList"] == null
                ? []
                : List<ElectronicApplianceImageList>.from(
                    json["electronicApplianceImageList"]!
                        .map((x) => ElectronicApplianceImageList.fromJson(x))),
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
        "electronicApplianceImageList": electronicApplianceImageList == null
            ? []
            : List<dynamic>.from(
                electronicApplianceImageList!.map((x) => x.toJson())),
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

class ElectronicApplianceImageList {
  int? electronicAppliancesId;
  int? id;
  String? imageId;
  String? imageUrl;

  ElectronicApplianceImageList({
    this.electronicAppliancesId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory ElectronicApplianceImageList.fromJson(Map<String, dynamic> json) =>
      ElectronicApplianceImageList(
        electronicAppliancesId: json["electronicAppliancesId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "electronicAppliancesId": electronicAppliancesId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
