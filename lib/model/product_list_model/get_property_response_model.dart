// To parse this JSON data, do
//
//     final getAllPropertyResponseModel = getAllPropertyResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllPropertyResponseModel> getAllPropertyResponseModelFromJson(
        String str) =>
    List<GetAllPropertyResponseModel>.from(
        json.decode(str).map((x) => GetAllPropertyResponseModel.fromJson(x)));

String getAllPropertyResponseModelToJson(
        List<GetAllPropertyResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllPropertyResponseModel {
  int? id;
  List<PropertyImageList>? propertyImageList;
  int? subCategoryId;
  int? houseType;
  int? serviceType;
  int? bedrooms;
  int? bathrooms;
  int? furnishingStatus;
  int? constructionStatus;
  int? listedBy;
  int? superBuildUpArea;
  int? carpetArea;
  bool? bachelorAllowed;
  int? maintenanceCharge;
  int? totalFloors;
  int? floorNumber;
  int? carParking;
  int? facingType;
  String? projectName;
  int? plotArea;
  int? lenght;
  int? breadth;
  bool? isMealIncluded;
  int? pgType;
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

  GetAllPropertyResponseModel({
    this.id,
    this.propertyImageList,
    this.subCategoryId,
    this.houseType,
    this.serviceType,
    this.bedrooms,
    this.bathrooms,
    this.furnishingStatus,
    this.constructionStatus,
    this.listedBy,
    this.superBuildUpArea,
    this.carpetArea,
    this.bachelorAllowed,
    this.maintenanceCharge,
    this.totalFloors,
    this.floorNumber,
    this.carParking,
    this.facingType,
    this.projectName,
    this.plotArea,
    this.lenght,
    this.breadth,
    this.isMealIncluded,
    this.pgType,
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

  factory GetAllPropertyResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllPropertyResponseModel(
        id: json["id"],
        propertyImageList: json["propertyImageList"] == null
            ? []
            : List<PropertyImageList>.from(json["propertyImageList"]!
                .map((x) => PropertyImageList.fromJson(x))),
        subCategoryId: json["subCategoryId"],
        houseType: json["houseType"],
        serviceType: json["serviceType"],
        bedrooms: json["bedrooms"],
        bathrooms: json["bathrooms"],
        furnishingStatus: json["furnishingStatus"],
        constructionStatus: json["constructionStatus"],
        listedBy: json["listedBy"],
        superBuildUpArea: json["superBuildUpArea"],
        carpetArea: json["carpetArea"],
        bachelorAllowed: json["bachelorAllowed"],
        maintenanceCharge: json["maintenanceCharge"],
        totalFloors: json["totalFloors"],
        floorNumber: json["floorNumber"],
        carParking: json["carParking"],
        facingType: json["facingType"],
        projectName: json["projectName"],
        plotArea: json["plotArea"],
        lenght: json["lenght"],
        breadth: json["breadth"],
        isMealIncluded: json["isMealIncluded"],
        pgType: json["pgType"],
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
        "propertyImageList": propertyImageList == null
            ? []
            : List<dynamic>.from(propertyImageList!.map((x) => x.toJson())),
        "subCategoryId": subCategoryId,
        "houseType": houseType,
        "serviceType": serviceType,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "furnishingStatus": furnishingStatus,
        "constructionStatus": constructionStatus,
        "listedBy": listedBy,
        "superBuildUpArea": superBuildUpArea,
        "carpetArea": carpetArea,
        "bachelorAllowed": bachelorAllowed,
        "maintenanceCharge": maintenanceCharge,
        "totalFloors": totalFloors,
        "floorNumber": floorNumber,
        "carParking": carParking,
        "facingType": facingType,
        "projectName": projectName,
        "plotArea": plotArea,
        "lenght": lenght,
        "breadth": breadth,
        "isMealIncluded": isMealIncluded,
        "pgType": pgType,
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

class PropertyImageList {
  int? propertyId;
  int? id;
  String? imageId;
  String? imageUrl;

  PropertyImageList({
    this.propertyId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory PropertyImageList.fromJson(Map<String, dynamic> json) =>
      PropertyImageList(
        propertyId: json["propertyId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "propertyId": propertyId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
