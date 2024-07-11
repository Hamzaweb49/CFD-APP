// To parse this JSON data, do
//
//     final getCarModelResponseModel = getCarModelResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetCarModelResponseModel> getCarModelResponseModelFromJson(String str) =>
    List<GetCarModelResponseModel>.from(
        json.decode(str).map((x) => GetCarModelResponseModel.fromJson(x)));

String getCarModelResponseModelToJson(List<GetCarModelResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCarModelResponseModel {
  int? id;
  String? model;
  int? carBrandId;

  GetCarModelResponseModel({
    this.id,
    this.model,
    this.carBrandId,
  });

  factory GetCarModelResponseModel.fromJson(Map<String, dynamic> json) =>
      GetCarModelResponseModel(
        id: json["id"],
        model: json["model"],
        carBrandId: json["carBrandId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model": model,
        "carBrandId": carBrandId,
      };
}
