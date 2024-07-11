// To parse this JSON data, do
//
//     final getJobsResponseModel = getJobsResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetJobsResponseModel> getJobsResponseModelFromJson(String str) =>
    List<GetJobsResponseModel>.from(
        json.decode(str).map((x) => GetJobsResponseModel.fromJson(x)));

String getJobsResponseModelToJson(List<GetJobsResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetJobsResponseModel {
  int? id;
  List<JobImageList>? jobImageList;
  int? subCategoryId;
  int? salaryPeriodType;
  int? positionType;
  int? salaryFrom;
  int? salaryTo;
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
  String? createdOn;
  int? modifiedBy;
  String? modifiedOn;
  String? tag;
  String? tableRefGuid;

  GetJobsResponseModel({
    this.id,
    this.jobImageList,
    this.subCategoryId,
    this.salaryPeriodType,
    this.positionType,
    this.salaryFrom,
    this.salaryTo,
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

  factory GetJobsResponseModel.fromJson(Map<String, dynamic> json) =>
      GetJobsResponseModel(
        id: json["id"],
        jobImageList: json["jobImageList"] == null
            ? []
            : List<JobImageList>.from(
                json["jobImageList"]!.map((x) => JobImageList.fromJson(x))),
        subCategoryId: json["subCategoryId"],
        salaryPeriodType: json["salaryPeriodType"],
        positionType: json["positionType"],
        salaryFrom: json["salaryFrom"],
        salaryTo: json["salaryTo"],
        categoryId: json["categoryId"],
        title: json["title"],
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
        createdOn: json["createdOn"],
        modifiedBy: json["modifiedBy"],
        modifiedOn: json["modifiedOn"],
        tag: json["tag"],
        tableRefGuid: json["tableRefGuid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jobImageList": jobImageList == null
            ? []
            : List<dynamic>.from(jobImageList!.map((x) => x.toJson())),
        "subCategoryId": subCategoryId,
        "salaryPeriodType": salaryPeriodType,
        "positionType": positionType,
        "salaryFrom": salaryFrom,
        "salaryTo": salaryTo,
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
        "createdOn": createdOn,
        "modifiedBy": modifiedBy,
        "modifiedOn": modifiedOn,
        "tag": tag,
        "tableRefGuid": tableRefGuid,
      };
}

class JobImageList {
  int? jobsId;
  int? id;
  String? imageId;
  String? imageUrl;

  JobImageList({
    this.jobsId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory JobImageList.fromJson(Map<String, dynamic> json) => JobImageList(
        jobsId: json["jobsId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "jobsId": jobsId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
