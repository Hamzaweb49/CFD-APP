// To parse this JSON data, do
//
//     final getAllStateResponseModel = getAllStateResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetAllStateResponseModel> getAllStateResponseModelFromJson(String str) =>
    List<GetAllStateResponseModel>.from(
        json.decode(str).map((x) => GetAllStateResponseModel.fromJson(x)));

String getAllStateResponseModelToJson(List<GetAllStateResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllStateResponseModel {
  int? id;
  String? name;
  int? countryId;

  GetAllStateResponseModel({
    this.id,
    this.name,
    this.countryId,
  });

  factory GetAllStateResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllStateResponseModel(
        id: json["id"],
        name: json["name"],
        countryId: json["countryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "countryId": countryId,
      };
}
