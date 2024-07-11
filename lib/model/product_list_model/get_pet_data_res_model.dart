// To parse this JSON data, do
//
//     final getAllPetDataResponseModel = getAllPetDataResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllPetDataResponseModel> getAllPetDataResponseModelFromJson(
        String str) =>
    List<GetAllPetDataResponseModel>.from(
        json.decode(str).map((x) => GetAllPetDataResponseModel.fromJson(x)));

String getAllPetDataResponseModelToJson(
        List<GetAllPetDataResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllPetDataResponseModel {
  int? id;
  List<PetImageList>? petImageList;
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

  GetAllPetDataResponseModel({
    this.id,
    this.petImageList,
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

  factory GetAllPetDataResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllPetDataResponseModel(
        id: json["id"],
        petImageList: json["petImageList"] == null
            ? []
            : List<PetImageList>.from(
                json["petImageList"]!.map((x) => PetImageList.fromJson(x))),
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
        "petImageList": petImageList == null
            ? []
            : List<dynamic>.from(petImageList!.map((x) => x.toJson())),
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

class PetImageList {
  int? petsId;
  int? id;
  String? imageId;
  String? imageUrl;

  PetImageList({
    this.petsId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory PetImageList.fromJson(Map<String, dynamic> json) => PetImageList(
        petsId: json["petsId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "petsId": petsId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
