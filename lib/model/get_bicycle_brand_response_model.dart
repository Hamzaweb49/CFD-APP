// To parse this JSON data, do
//
//     final getBicycleBrandResponseModel = getBicycleBrandResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetBicycleBrandResponseModel> getBicycleBrandResponseModelFromJson(
        String str) =>
    List<GetBicycleBrandResponseModel>.from(
        json.decode(str).map((x) => GetBicycleBrandResponseModel.fromJson(x)));

String getBicycleBrandResponseModelToJson(
        List<GetBicycleBrandResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBicycleBrandResponseModel {
  int? id;
  String? brandName;

  GetBicycleBrandResponseModel({
    this.id,
    this.brandName,
  });

  factory GetBicycleBrandResponseModel.fromJson(Map<String, dynamic> json) =>
      GetBicycleBrandResponseModel(
        id: json["id"],
        brandName: json["brandName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brandName": brandName,
      };
}
