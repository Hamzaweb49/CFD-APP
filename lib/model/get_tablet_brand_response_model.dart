// To parse this JSON data, do
//
//     final getTabletBrandResponseModel = getTabletBrandResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetTabletBrandResponseModel> getTabletBrandResponseModelFromJson(
        String str) =>
    List<GetTabletBrandResponseModel>.from(
        json.decode(str).map((x) => GetTabletBrandResponseModel.fromJson(x)));

String getTabletBrandResponseModelToJson(
        List<GetTabletBrandResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTabletBrandResponseModel {
  int? id;
  String? brandName;

  GetTabletBrandResponseModel({
    this.id,
    this.brandName,
  });

  factory GetTabletBrandResponseModel.fromJson(Map<String, dynamic> json) =>
      GetTabletBrandResponseModel(
        id: json["id"],
        brandName: json["brandName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brandName": brandName,
      };
}
