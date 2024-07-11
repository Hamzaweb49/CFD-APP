// To parse this JSON data, do
//
//     final getMobileBrandResponseModel = getMobileBrandResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetMobileBrandResponseModel> getMobileBrandResponseModelFromJson(
        String str) =>
    List<GetMobileBrandResponseModel>.from(
        json.decode(str).map((x) => GetMobileBrandResponseModel.fromJson(x)));

String getMobileBrandResponseModelToJson(
        List<GetMobileBrandResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetMobileBrandResponseModel {
  int? id;
  String? brandName;

  GetMobileBrandResponseModel({
    this.id,
    this.brandName,
  });

  factory GetMobileBrandResponseModel.fromJson(Map<String, dynamic> json) =>
      GetMobileBrandResponseModel(
        id: json["id"],
        brandName: json["brandName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brandName": brandName,
      };
}
