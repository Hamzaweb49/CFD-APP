// To parse this JSON data, do
//
//     final getAllWishListResponseModel = getAllWishListResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllWishListResponseModel> getAllWishListResponseModelFromJson(
        String str) =>
    List<GetAllWishListResponseModel>.from(
        json.decode(str).map((x) => GetAllWishListResponseModel.fromJson(x)));

String getAllWishListResponseModelToJson(
        List<GetAllWishListResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllWishListResponseModel {
  int? id;
  String? productId;
  int? categoryId;
  int? createdBy;
  String? createdOn;

  GetAllWishListResponseModel({
    this.id,
    this.productId,
    this.categoryId,
    this.createdBy,
    this.createdOn,
  });

  factory GetAllWishListResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllWishListResponseModel(
        id: json["id"],
        productId: json["productId"],
        categoryId: json["categoryId"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "categoryId": categoryId,
        "createdBy": createdBy,
        "createdOn": createdOn,
      };
}
