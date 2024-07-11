// To parse this JSON data, do
//
//     final getAllNearByResponseModel = getAllNearByResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllNearByResponseModel> getAllNearByResponseModelFromJson(String str) =>
    List<GetAllNearByResponseModel>.from(
        json.decode(str).map((x) => GetAllNearByResponseModel.fromJson(x)));

String getAllNearByResponseModelToJson(List<GetAllNearByResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllNearByResponseModel {
  int? id;
  String? name;
  int? cityId;

  GetAllNearByResponseModel({
    this.id,
    this.name,
    this.cityId,
  });

  factory GetAllNearByResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllNearByResponseModel(
        id: json["id"],
        name: json["name"],
        cityId: json["cityId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cityId": cityId,
      };
}
