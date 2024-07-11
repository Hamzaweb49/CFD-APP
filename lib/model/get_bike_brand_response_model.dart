// To parse this JSON data, do
//
//     final getBikeBrandResponseModel = getBikeBrandResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetBikeBrandResponseModel> getBikeBrandResponseModelFromJson(String str) =>
    List<GetBikeBrandResponseModel>.from(
        json.decode(str).map((x) => GetBikeBrandResponseModel.fromJson(x)));

String getBikeBrandResponseModelToJson(List<GetBikeBrandResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBikeBrandResponseModel {
  int? id;
  String? brandName;

  GetBikeBrandResponseModel({
    this.id,
    this.brandName,
  });

  factory GetBikeBrandResponseModel.fromJson(Map<String, dynamic> json) =>
      GetBikeBrandResponseModel(
        id: json["id"],
        brandName: json["brandName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brandName": brandName,
      };
}
