// To parse this JSON data, do
//
//     final getAllCommercialServicesResponseModel = getAllCommercialServicesResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllCommercialServicesResponseModel>
    getAllCommercialServicesResponseModelFromJson(String str) =>
        List<GetAllCommercialServicesResponseModel>.from(json
            .decode(str)
            .map((x) => GetAllCommercialServicesResponseModel.fromJson(x)));

String getAllCommercialServicesResponseModelToJson(
        List<GetAllCommercialServicesResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllCommercialServicesResponseModel {
  int? id;
  int? subCategoryId;
  List<CommercialServiceImagesList>? commercialServiceImagesList;
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

  GetAllCommercialServicesResponseModel({
    this.id,
    this.subCategoryId,
    this.commercialServiceImagesList,
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

  factory GetAllCommercialServicesResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetAllCommercialServicesResponseModel(
        id: json["id"],
        subCategoryId: json["subCategoryId"],
        commercialServiceImagesList: json["commercialServiceImagesList"] == null
            ? []
            : List<CommercialServiceImagesList>.from(
                json["commercialServiceImagesList"]!
                    .map((x) => CommercialServiceImagesList.fromJson(x))),
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
        "subCategoryId": subCategoryId,
        "commercialServiceImagesList": commercialServiceImagesList == null
            ? []
            : List<dynamic>.from(
                commercialServiceImagesList!.map((x) => x.toJson())),
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

class CommercialServiceImagesList {
  int? commercialServicesId;
  int? id;
  String? imageId;
  String? imageUrl;

  CommercialServiceImagesList({
    this.commercialServicesId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory CommercialServiceImagesList.fromJson(Map<String, dynamic> json) =>
      CommercialServiceImagesList(
        commercialServicesId: json["commercialServicesId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "commercialServicesId": commercialServicesId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
