// To parse this JSON data, do
//
//     final getAllCategoryResponseModel = getAllCategoryResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllCategoryResponseModel> getAllCategoryResponseModelFromJson(String str) => List<GetAllCategoryResponseModel>.from(json.decode(str).map((x) => GetAllCategoryResponseModel.fromJson(x)));

String getAllCategoryResponseModelToJson(List<GetAllCategoryResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllCategoryResponseModel {
  int? id;
  String? categoryName;

  GetAllCategoryResponseModel({
    this.id,
    this.categoryName,
  });

  factory GetAllCategoryResponseModel.fromJson(Map<String, dynamic> json) => GetAllCategoryResponseModel(
    id: json["id"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
  };
}
