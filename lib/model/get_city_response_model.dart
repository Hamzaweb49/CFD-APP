import 'dart:convert';

List<GetAllCityResponseModel> getAllCityResponseModelFromJson(String str) =>
    List<GetAllCityResponseModel>.from(
        json.decode(str).map((x) => GetAllCityResponseModel.fromJson(x)));

String getAllCityResponseModelToJson(List<GetAllCityResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllCityResponseModel {
  int? id;
  String? name;
  int? stateId;

  GetAllCityResponseModel({
    this.id,
    this.name,
    this.stateId,
  });

  factory GetAllCityResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllCityResponseModel(
        id: json["id"],
        name: json["name"],
        stateId: json["stateId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stateId": stateId,
      };
}
