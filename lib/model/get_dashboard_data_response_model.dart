// To parse this JSON data, do
//
//     final getAllDashboardDataResponseModel = getAllDashboardDataResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllDashboardDataResponseModel> getAllDashboardDataResponseModelFromJson(
        String str) =>
    List<GetAllDashboardDataResponseModel>.from(json
        .decode(str)
        .map((x) => GetAllDashboardDataResponseModel.fromJson(x)));

String getAllDashboardDataResponseModelToJson(
        List<GetAllDashboardDataResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllDashboardDataResponseModel {
  int? id;
  int? categoryId;
  String? tableRefGuid;
  String? title;
  String? discription;
  int? price;
  dynamic gadgetImageList;
  dynamic vehicleImageList;
  dynamic propertyImageList;
  dynamic jobImageList;
  dynamic electronicApplianceImageList;
  dynamic furnitureImageList;
  dynamic bookImageList;
  dynamic sportImageList;
  dynamic petImageList;
  dynamic fashionImageList;
  dynamic commercialServiceImageList;
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
  List<DashBoardImageList>? productImage;
  int? subCategoryId;
  int? mobileBrandId;
  int? modifiedBy;
  DateTime? modifiedOn;
  String? tag;

  GetAllDashboardDataResponseModel(
      {this.id,
      this.categoryId,
      this.tableRefGuid,
      this.title,
      this.discription,
      this.price,
      this.gadgetImageList,
      this.vehicleImageList,
      this.propertyImageList,
      this.jobImageList,
      this.electronicApplianceImageList,
      this.furnitureImageList,
      this.bookImageList,
      this.sportImageList,
      this.petImageList,
      this.fashionImageList,
      this.commercialServiceImageList,
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
      this.productImage,
      this.subCategoryId,
      this.mobileBrandId,
      this.tag,
      this.modifiedBy,
      this.modifiedOn});

  factory GetAllDashboardDataResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetAllDashboardDataResponseModel(
        id: json["id"],
        categoryId: json["categoryId"],
        tableRefGuid: json["tableRefGuid"],
        title: json["title"],
        discription: json["discription"],
        price: json["price"],
        gadgetImageList: json["gadgetImageList"] == null
            ? []
            : List<DashBoardImageList>.from(json["gadgetImageList"]!
                .map((x) => DashBoardImageList.fromJson(x))),
        vehicleImageList: json["vehicleImageList"] == null
            ? []
            : List<DashBoardImageList>.from(json["vehicleImageList"]!
                .map((x) => DashBoardImageList.fromJson(x))),
        propertyImageList: json["propertyImageList"] == null
            ? []
            : List<DashBoardImageList>.from(json["propertyImageList"]!
                .map((x) => DashBoardImageList.fromJson(x))),
        jobImageList: json["jobImageList"] == null
            ? []
            : List<DashBoardImageList>.from(json["jobImageList"]!
                .map((x) => DashBoardImageList.fromJson(x))),
        electronicApplianceImageList:
            json["electronicApplianceImageList"] == null
                ? []
                : List<DashBoardImageList>.from(
                    json["electronicApplianceImageList"]!
                        .map((x) => DashBoardImageList.fromJson(x))),
        furnitureImageList: json["furnitureImageList"] == null
            ? []
            : List<DashBoardImageList>.from(json["furnitureImageList"]!
                .map((x) => DashBoardImageList.fromJson(x))),
        bookImageList: json["bookImageList"] == null
            ? []
            : List<DashBoardImageList>.from(json["bookImageList"]!
                .map((x) => DashBoardImageList.fromJson(x))),
        sportImageList: json["sportImageList"] == null
            ? []
            : List<DashBoardImageList>.from(json["sportImageList"]!
                .map((x) => DashBoardImageList.fromJson(x))),
        petImageList: json["petImageList"] == null
            ? []
            : List<DashBoardImageList>.from(json["petImageList"]!
                .map((x) => DashBoardImageList.fromJson(x))),
        fashionImageList: json["fashionImageList"] == null
            ? []
            : List<DashBoardImageList>.from(json["fashionImageList"]!
                .map((x) => DashBoardImageList.fromJson(x))),
        commercialServiceImageList: json["commercialServiceImageList"] == null
            ? []
            : List<DashBoardImageList>.from(json["commercialServiceImageList"]!
                .map((x) => DashBoardImageList.fromJson(x))),
        pincode: json["pincode"],
        state: json["state"] ?? "",
        city: json["city"] ?? "",
        nearBy: json["nearBy"] ?? "",
        name: json["name"] ?? "",
        mobile: json["mobile"],
        isPremium: json["isPremium"],
        isActive: json["isActive"],
        isVerified: json["isVerified"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"] == null
            ? null
            : DateTime.parse(json["createdOn"]),
        subCategoryId: json["subCategoryId"],
        mobileBrandId: json["mobileBrandId"],
        modifiedBy: json["modifiedBy"],
        modifiedOn: json["modifiedOn"] == null
            ? null
            : DateTime.parse(json["modifiedOn"]),
        tag: json["tag"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
        "title": title,
        "discription": discription,
        "price": price,
        "gadgetImageList": gadgetImageList == null
            ? []
            : List<dynamic>.from(gadgetImageList!.map((x) => x.toJson())),
        "vehicleImageList": vehicleImageList == null
            ? []
            : List<dynamic>.from(vehicleImageList!.map((x) => x.toJson())),
        "propertyImageList": propertyImageList == null
            ? []
            : List<dynamic>.from(propertyImageList!.map((x) => x.toJson())),
        "jobImageList": jobImageList == null
            ? []
            : List<dynamic>.from(jobImageList!.map((x) => x.toJson())),
        "electronicApplianceImageList": electronicApplianceImageList == null
            ? []
            : List<dynamic>.from(
                electronicApplianceImageList!.map((x) => x.toJson())),
        "furnitureImageList": furnitureImageList == null
            ? []
            : List<dynamic>.from(furnitureImageList!.map((x) => x.toJson())),
        "bookImageList": bookImageList == null
            ? []
            : List<dynamic>.from(bookImageList!.map((x) => x.toJson())),
        "sportImageList": sportImageList == null
            ? []
            : List<dynamic>.from(sportImageList!.map((x) => x.toJson())),
        "petImageList": petImageList == null
            ? []
            : List<dynamic>.from(petImageList!.map((x) => x.toJson())),
        "fashionImageList": fashionImageList == null
            ? []
            : List<dynamic>.from(fashionImageList!.map((x) => x.toJson())),
        "commercialServiceImageList": commercialServiceImageList == null
            ? []
            : List<dynamic>.from(
                commercialServiceImageList!.map((x) => x.toJson())),
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
        "mobileBrandId": mobileBrandId,
        "tableRefGuid": tableRefGuid,
        "modifiedBy": modifiedBy,
        "modifiedOn": modifiedOn?.toIso8601String(),
        "tag": tag,
      };
}

class DashBoardImageList {
  int? booksId;
  int? id;
  String? imageId;
  String? imageUrl;
  int? commercialServicesId;
  int? electronicAppliancesId;
  int? fashionId;
  int? furnituresId;
  int? gadgetsId;
  int? jobsId;
  int? petsId;
  int? propertyId;
  int? sportsId;
  int? vehiclesId;

  DashBoardImageList({
    this.booksId,
    this.id,
    this.imageId,
    this.imageUrl,
    this.commercialServicesId,
    this.electronicAppliancesId,
    this.fashionId,
    this.furnituresId,
    this.gadgetsId,
    this.jobsId,
    this.petsId,
    this.propertyId,
    this.sportsId,
    this.vehiclesId,
  });

  factory DashBoardImageList.fromJson(Map<String, dynamic> json) =>
      DashBoardImageList(
        booksId: json["booksId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
        commercialServicesId: json["commercialServicesId"],
        electronicAppliancesId: json["electronicAppliancesId"],
        fashionId: json["fashionId"],
        furnituresId: json["furnituresId"],
        gadgetsId: json["gadgetsId"],
        jobsId: json["jobsId"],
        petsId: json["petsId"],
        propertyId: json["propertyId"],
        sportsId: json["sportsId"],
        vehiclesId: json["vehiclesId"],
      );

  Map<String, dynamic> toJson() => {
        "booksId": booksId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
        "commercialServicesId": commercialServicesId,
        "electronicAppliancesId": electronicAppliancesId,
        "fashionId": fashionId,
        "furnituresId": furnituresId,
        "gadgetsId": gadgetsId,
        "jobsId": jobsId,
        "petsId": petsId,
        "propertyId": propertyId,
        "sportsId": sportsId,
        "vehiclesId": vehiclesId,
      };
}
