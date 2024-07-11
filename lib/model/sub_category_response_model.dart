// To parse this JSON data, do
//
//     final selectedCategoryResponseModel = selectedCategoryResponseModelFromJson(jsonString);

import 'dart:convert';

List<SubCategoryResponseModel> selectedCategoryResponseModelFromJson(
        String str) =>
    List<SubCategoryResponseModel>.from(
        json.decode(str).map((x) => SubCategoryResponseModel.fromJson(x)));

String selectedCategoryResponseModelToJson(
        List<SubCategoryResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoryResponseModel {
  int? id;
  int? categoryId;
  String? subCategoryName;

  SubCategoryResponseModel({
    this.id,
    this.categoryId,
    this.subCategoryName,
  });

  factory SubCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryResponseModel(
        id: json["id"],
        categoryId: json["categoryId"],
        subCategoryName: json["subCategoryName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "subCategoryName": subCategoryName,
      };
}
