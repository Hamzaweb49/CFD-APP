import 'dart:convert';

List<GetAllSportsDataResponseModel> getAllSportsDataResponseModelFromJson(
        String str) =>
    List<GetAllSportsDataResponseModel>.from(
        json.decode(str).map((x) => GetAllSportsDataResponseModel.fromJson(x)));

String getAllSportsDataResponseModelToJson(
        List<GetAllSportsDataResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllSportsDataResponseModel {
  int? id;
  int? subCategoryId;
  List<SportImageList>? sportImageList;
  int? categoryId;
  String? title;
  String? discription;
  int? price;
  String? pincode;
  String? state;
  String? city;
  String? nearBy;
  String? name;
  String? mobile;
  bool? isPremium;
  bool? isActive;
  bool? isVerified;
  int? createdBy;
  DateTime? createdOn;
  int? modifiedBy;
  DateTime? modifiedOn;
  dynamic tag;
  String? tableRefGuid;

  GetAllSportsDataResponseModel({
    this.id,
    this.subCategoryId,
    this.sportImageList,
    this.categoryId,
    this.title,
    this.discription,
    this.price,
    this.pincode,
    this.state,
    this.city,
    this.nearBy,
    this.name,
    this.mobile,
    this.isPremium,
    this.isActive,
    this.isVerified,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
    this.tag,
    this.tableRefGuid,
  });

  factory GetAllSportsDataResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllSportsDataResponseModel(
        id: json["id"],
        subCategoryId: json["subCategoryId"],
        sportImageList: json["sportImageList"] == null
            ? []
            : List<SportImageList>.from(
                json["sportImageList"]!.map((x) => SportImageList.fromJson(x))),
        categoryId: json["categoryId"],
        title: json["title"] ?? "",
        discription: json["discription"],
        price: json["price"],
        pincode: json["pincode"],
        state: json["state"],
        city: json["city"],
        nearBy: json["nearBy"],
        name: json["name"],
        mobile: json["mobile"],
        isPremium: json["isPremium"],
        isActive: json["isActive"],
        isVerified: json["isVerified"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"] == null
            ? null
            : DateTime.parse(json["createdOn"]),
        modifiedBy: json["modifiedBy"],
        modifiedOn: json["modifiedOn"] == null
            ? null
            : DateTime.parse(json["modifiedOn"]),
        tag: json["tag"],
        tableRefGuid: json["tableRefGuid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subCategoryId": subCategoryId,
        "sportImageList": sportImageList == null
            ? []
            : List<dynamic>.from(sportImageList!.map((x) => x.toJson())),
        "categoryId": categoryId,
        "title": title,
        "discription": discription,
        "price": price,
        "pincode": pincode,
        "state": state,
        "city": city,
        "nearBy": nearBy,
        "name": name,
        "mobile": mobile,
        "isPremium": isPremium,
        "isActive": isActive,
        "isVerified": isVerified,
        "createdBy": createdBy,
        "createdOn": createdOn?.toIso8601String(),
        "modifiedBy": modifiedBy,
        "modifiedOn": modifiedOn?.toIso8601String(),
        "tag": tag,
        "tableRefGuid": tableRefGuid,
      };
}

class SportImageList {
  int? sportsId;
  int? id;
  String? imageId;
  String? imageUrl;

  SportImageList({
    this.sportsId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory SportImageList.fromJson(Map<String, dynamic> json) => SportImageList(
        sportsId: json["sportsId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "sportsId": sportsId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
