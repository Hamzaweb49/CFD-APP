// To parse this JSON data, do
//
//     final getScootyBrandResponseModel = getScootyBrandResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetScootyBrandResponseModel> getScootyBrandResponseModelFromJson(
        String str) =>
    List<GetScootyBrandResponseModel>.from(
        json.decode(str).map((x) => GetScootyBrandResponseModel.fromJson(x)));

String getScootyBrandResponseModelToJson(
        List<GetScootyBrandResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetScootyBrandResponseModel {
  int? id;
  String? brandName;

  GetScootyBrandResponseModel({
    this.id,
    this.brandName,
  });

  factory GetScootyBrandResponseModel.fromJson(Map<String, dynamic> json) =>
      GetScootyBrandResponseModel(
        id: json["id"],
        brandName: json["brandName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brandName": brandName,
      };
}
