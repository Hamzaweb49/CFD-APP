// To parse this JSON data, do
//
//     final getAllAdsResponseModel = getAllAdsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:claxified_app/model/product_list_model/get_all_electronics_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_book_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_commercial_services_res_model.dart';
import 'package:claxified_app/model/product_list_model/get_fashion_data_res_model.dart';
import 'package:claxified_app/model/product_list_model/get_furniture_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_pet_data_res_model.dart';
import 'package:claxified_app/model/product_list_model/get_sports_data_res_model.dart';

List<GetAllAdsResponseModel> getAllAdsResponseModelFromJson(String str) =>
    List<GetAllAdsResponseModel>.from(
        json.decode(str).map((x) => GetAllAdsResponseModel.fromJson(x)));

String getAllAdsResponseModelToJson(List<GetAllAdsResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllAdsResponseModel {
  int? id;
  int? categoryId;
  String? tableRefGuid;
  String? title;
  String? discription;
  int? price;
  List<GadgetImageList> gadgetImageList;
  List<VehicleImageList> vehicleImageList;
  List<PropertyImageList> propertyImageList;
  List<JobImageList> jobImageList;
  List<ElectronicApplianceImageList> electronicApplianceImageList;
  List<FurnitureImageList> furnitureImageList;
  List<BookImageList> bookImageList;
  List<SportImageList> sportImageList;
  List<PetImageList> petImageList;
  List<FashionImageList> fashionImageList;
  List<CommercialServiceImagesList> commercialServiceImageList;
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

  GetAllAdsResponseModel({
    this.id,
    this.categoryId,
    this.tableRefGuid,
    this.title,
    this.discription,
    this.price,
    required this.gadgetImageList,
    required this.vehicleImageList,
    required this.propertyImageList,
    required this.jobImageList,
    required this.electronicApplianceImageList,
    required this.furnitureImageList,
    required this.bookImageList,
    required this.sportImageList,
    required this.petImageList,
    required this.fashionImageList,
    required this.commercialServiceImageList,
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
  });

  factory GetAllAdsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllAdsResponseModel(
        id: json["id"],
        categoryId: json["categoryId"],
        tableRefGuid: json["tableRefGuid"],
        title: json["title"],
        discription: json["discription"],
        price: json["price"],
        gadgetImageList: json["gadgetImageList"] == null
            ? []
            : List<GadgetImageList>.from(json["gadgetImageList"]!
                .map((x) => GadgetImageList.fromJson(x))),
        vehicleImageList: json["vehicleImageList"] == null
            ? []
            : List<VehicleImageList>.from(json["vehicleImageList"]!
                .map((x) => VehicleImageList.fromJson(x))),
        propertyImageList: json["propertyImageList"] == null
            ? []
            : List<PropertyImageList>.from(json["propertyImageList"]!
                .map((x) => PropertyImageList.fromJson(x))),
        jobImageList: json["jobImageList"] == null
            ? []
            : List<JobImageList>.from(
                json["jobImageList"]!.map((x) => JobImageList.fromJson(x))),
        electronicApplianceImageList:
            json["electronicApplianceImageList"] == null
                ? []
                : List<ElectronicApplianceImageList>.from(
                    json["electronicApplianceImageList"]!
                        .map((x) => ElectronicApplianceImageList.fromJson(x))),
        furnitureImageList: json["furnitureImageList"] == null
            ? []
            : List<FurnitureImageList>.from(json["furnitureImageList"]!
                .map((x) => FurnitureImageList.fromJson(x))),
        bookImageList: json["bookImageList"] == null
            ? []
            : List<BookImageList>.from(
                json["bookImageList"]!.map((x) => BookImageList.fromJson(x))),
        sportImageList: json["sportImageList"] == null
            ? []
            : List<SportImageList>.from(
                json["sportImageList"]!.map((x) => SportImageList.fromJson(x))),
        petImageList: json["petImageList"] == null
            ? []
            : List<PetImageList>.from(
                json["petImageList"]!.map((x) => PetImageList.fromJson(x))),
        fashionImageList: json["fashionImageList"] == null
            ? []
            : List<FashionImageList>.from(json["fashionImageList"]!
                .map((x) => FashionImageList.fromJson(x))),
        commercialServiceImageList: json["commercialServiceImageList"] == null
            ? []
            : List<CommercialServiceImagesList>.from(
                json["commercialServiceImageList"]!
                    .map((x) => CommercialServiceImagesList.fromJson(x))),
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "tableRefGuid": tableRefGuid,
        "title": title,
        "discription": discription,
        "price": price,
        "gadgetImageList": gadgetImageList.isEmpty
            ? []
            : List<dynamic>.from(gadgetImageList.map((x) => x.toJson())),
        "vehicleImageList": vehicleImageList.isEmpty
            ? []
            : List<dynamic>.from(vehicleImageList.map((x) => x.toJson())),
        "propertyImageList": propertyImageList.isEmpty
            ? []
            : List<dynamic>.from(propertyImageList.map((x) => x.toJson())),
        "jobImageList": jobImageList.isEmpty
            ? []
            : List<dynamic>.from(jobImageList.map((x) => x.toJson())),
        "electronicApplianceImageList": electronicApplianceImageList.isEmpty
            ? []
            : List<dynamic>.from(
                electronicApplianceImageList.map((x) => x.toJson())),
        "furnitureImageList": furnitureImageList.isEmpty
            ? []
            : List<dynamic>.from(furnitureImageList.map((x) => x.toJson())),
        "bookImageList": bookImageList.isEmpty
            ? []
            : List<dynamic>.from(bookImageList.map((x) => x.toJson())),
        "sportImageList": sportImageList.isEmpty
            ? []
            : List<dynamic>.from(sportImageList.map((x) => x.toJson())),
        "petImageList": petImageList.isEmpty
            ? []
            : List<dynamic>.from(petImageList.map((x) => x.toJson())),
        "fashionImageList": fashionImageList.isEmpty
            ? []
            : List<dynamic>.from(fashionImageList.map((x) => x.toJson())),
        "commercialServiceImageList": commercialServiceImageList.isEmpty
            ? []
            : List<dynamic>.from(
                commercialServiceImageList.map((x) => x.toJson())),
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

class JobImageList {
  int? jobsId;
  int? id;
  String? imageId;
  String? imageUrl;

  JobImageList({
    this.jobsId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory JobImageList.fromJson(Map<String, dynamic> json) => JobImageList(
        jobsId: json["jobsId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "jobsId": jobsId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
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

class ElectronicApplianceImageList {
  int? electricAppliancesId;
  int? id;
  String? imageId;
  String? imageUrl;

  ElectronicApplianceImageList({
    this.electricAppliancesId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory ElectronicApplianceImageList.fromJson(Map<String, dynamic> json) =>
      ElectronicApplianceImageList(
        electricAppliancesId: json["electricAppliancesId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "electricAppliancesId": electricAppliancesId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}

class BookImageList {
  int? booksId;
  int? id;
  String? imageId;
  String? imageUrl;

  BookImageList({
    this.booksId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory BookImageList.fromJson(Map<String, dynamic> json) => BookImageList(
        booksId: json["booksId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "booksId": booksId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
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

class SportImageList {
  int? sportsId;
  int? id;
  String? imageId;
  String? imageUrl;

  SportImageList({
    this.sportsId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory SportImageList.fromJson(Map<String, dynamic> json) => SportImageList(
        sportsId: json["sportsId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "sportsId": sportsId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
