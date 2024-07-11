// To parse this JSON data, do
//
//     final getPincodeDetailsResponseModel = getPincodeDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetPincodeDetailsResponseModel> getPincodeDetailsResponseModelFromJson(
        String str) =>
    List<GetPincodeDetailsResponseModel>.from(json
        .decode(str)
        .map((x) => GetPincodeDetailsResponseModel.fromJson(x)));

String getPincodeDetailsResponseModelToJson(
        List<GetPincodeDetailsResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetPincodeDetailsResponseModel {
  String? message;
  String? status;
  List<PostOffice>? postOffice;

  GetPincodeDetailsResponseModel({
    this.message,
    this.status,
    this.postOffice,
  });

  factory GetPincodeDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetPincodeDetailsResponseModel(
        message: json["Message"],
        status: json["Status"],
        postOffice: json["PostOffice"] == null
            ? []
            : List<PostOffice>.from(
                json["PostOffice"]!.map((x) => PostOffice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Message": message,
        "Status": status,
        "PostOffice": postOffice == null
            ? []
            : List<dynamic>.from(postOffice!.map((x) => x.toJson())),
      };
}

class PostOffice {
  String? name;
  dynamic description;
  String? branchType;
  String? deliveryStatus;
  String? circle;
  String? district;
  String? division;
  String? region;
  String? block;
  String? state;
  String? country;
  String? pincode;

  PostOffice({
    this.name,
    this.description,
    this.branchType,
    this.deliveryStatus,
    this.circle,
    this.district,
    this.division,
    this.region,
    this.block,
    this.state,
    this.country,
    this.pincode,
  });

  factory PostOffice.fromJson(Map<String, dynamic> json) => PostOffice(
        name: json["Name"],
        description: json["Description"],
        branchType: json["BranchType"],
        deliveryStatus: json["DeliveryStatus"],
        circle: json["Circle"],
        district: json["District"],
        division: json["Division"],
        region: json["Region"],
        block: json["Block"],
        state: json["State"],
        country: json["Country"],
        pincode: json["Pincode"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Description": description,
        "BranchType": branchType,
        "DeliveryStatus": deliveryStatus,
        "Circle": circle,
        "District": district,
        "Division": division,
        "Region": region,
        "Block": block,
        "State": state,
        "Country": country,
        "Pincode": pincode,
      };
}
