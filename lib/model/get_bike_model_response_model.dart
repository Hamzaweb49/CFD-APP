// To parse this JSON data, do
//
//     final getBikeModelResponseModel = getBikeModelResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetBikeModelResponseModel> getBikeModelResponseModelFromJson(String str) =>
    List<GetBikeModelResponseModel>.from(
        json.decode(str).map((x) => GetBikeModelResponseModel.fromJson(x)));

String getBikeModelResponseModelToJson(List<GetBikeModelResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBikeModelResponseModel {
  int? id;
  String? model;
  int? bikeBrandId;

  GetBikeModelResponseModel({
    this.id,
    this.model,
    this.bikeBrandId,
  });

  factory GetBikeModelResponseModel.fromJson(Map<String, dynamic> json) =>
      GetBikeModelResponseModel(
        id: json["id"],
        model: json["model"],
        bikeBrandId: json["bikeBrandId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "model": model,
        "bikeBrandId": bikeBrandId,
      };
}
