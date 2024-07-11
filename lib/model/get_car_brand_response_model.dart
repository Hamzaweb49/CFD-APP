// To parse this JSON data, do
//
//     final getCarBrandResponseModel = getCarBrandResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetCarBrandResponseModel> getCarBrandResponseModelFromJson(String str) =>
    List<GetCarBrandResponseModel>.from(
        json.decode(str).map((x) => GetCarBrandResponseModel.fromJson(x)));

String getCarBrandResponseModelToJson(List<GetCarBrandResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCarBrandResponseModel {
  int? id;
  String? brandName;

  GetCarBrandResponseModel({
    this.id,
    this.brandName,
  });

  factory GetCarBrandResponseModel.fromJson(Map<String, dynamic> json) =>
      GetCarBrandResponseModel(
        id: json["id"],
        brandName: json["brandName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brandName": brandName,
      };
}
