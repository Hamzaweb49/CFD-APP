// To parse this JSON data, do
//
//     final getAllVehicleResponseModel = getAllVehicleResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllVehicleResponseModel> getAllVehicleResponseModelFromJson(
        String str) =>
    List<GetAllVehicleResponseModel>.from(
        json.decode(str).map((x) => GetAllVehicleResponseModel.fromJson(x)));

String getAllVehicleResponseModelToJson(
        List<GetAllVehicleResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllVehicleResponseModel {
  int? id;
  List<VehicleImageList>? vehicleImageList;
  int? subCategoryId;
  int? fuelType;
  int? vehicelBrandId;
  int? modelId;
  int? carType;
  int? year;
  int? transmissionType;
  int? kmDriven;
  int? noOfOwner;
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
  dynamic tag;
  String? tableRefGuid;

  GetAllVehicleResponseModel({
    this.id,
    this.vehicleImageList,
    this.subCategoryId,
    this.fuelType,
    this.vehicelBrandId,
    this.modelId,
    this.carType,
    this.year,
    this.transmissionType,
    this.kmDriven,
    this.noOfOwner,
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

  factory GetAllVehicleResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllVehicleResponseModel(
        id: json["id"],
        vehicleImageList: json["vehicleImageList"] == null
            ? []
            : List<VehicleImageList>.from(json["vehicleImageList"]!
                .map((x) => VehicleImageList.fromJson(x))),
        subCategoryId: json["subCategoryId"],
        fuelType: json["fuelType"],
        vehicelBrandId: json["vehicelBrandId"],
        modelId: json["modelId"],
        carType: json["carType"],
        year: json["year"],
        transmissionType: json["transmissionType"],
        kmDriven: json["kmDriven"],
        noOfOwner: json["noOfOwner"],
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
        "vehicleImageList": vehicleImageList == null
            ? []
            : List<dynamic>.from(vehicleImageList!.map((x) => x.toJson())),
        "subCategoryId": subCategoryId,
        "fuelType": fuelType,
        "vehicelBrandId": vehicelBrandId,
        "modelId": modelId,
        "carType": carType,
        "year": year,
        "transmissionType": transmissionType,
        "kmDriven": kmDriven,
        "noOfOwner": noOfOwner,
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

class VehicleImageList {
  int? vehiclesId;
  int? id;
  String? imageId;
  String? imageUrl;

  VehicleImageList({
    this.vehiclesId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory VehicleImageList.fromJson(Map<String, dynamic> json) =>
      VehicleImageList(
        vehiclesId: json["vehiclesId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "vehiclesId": vehiclesId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
