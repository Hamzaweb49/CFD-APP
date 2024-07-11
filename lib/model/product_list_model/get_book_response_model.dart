// To parse this JSON data, do
//
//     final getBookResponseModel = getBookResponseModelFromJson(jsonString);

import 'dart:convert';

List<GetBookResponseModel> getBookResponseModelFromJson(String str) =>
    List<GetBookResponseModel>.from(
        json.decode(str).map((x) => GetBookResponseModel.fromJson(x)));

String getBookResponseModelToJson(List<GetBookResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBookResponseModel {
  int? id;
  int? subCategoryId;
  List<BookImageList>? bookImageList;
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
  dynamic tag;
  String? tableRefGuid;

  GetBookResponseModel({
    this.id,
    this.subCategoryId,
    this.bookImageList,
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

  factory GetBookResponseModel.fromJson(Map<String, dynamic> json) =>
      GetBookResponseModel(
        id: json["id"],
        subCategoryId: json["subCategoryId"],
        bookImageList: json["bookImageList"] == null
            ? []
            : List<BookImageList>.from(
                json["bookImageList"]!.map((x) => BookImageList.fromJson(x))),
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
        "subCategoryId": subCategoryId,
        "bookImageList": bookImageList == null
            ? []
            : List<dynamic>.from(bookImageList!.map((x) => x.toJson())),
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

class BookImageList {
  int? booksId;
  int? id;
  String? imageId;
  String? imageUrl;

  BookImageList({
    this.booksId,
    this.id,
    this.imageId,
    this.imageUrl,
  });

  factory BookImageList.fromJson(Map<String, dynamic> json) => BookImageList(
        booksId: json["booksId"],
        id: json["id"],
        imageId: json["imageId"],
        imageUrl: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "booksId": booksId,
        "id": id,
        "imageId": imageId,
        "imageURL": imageUrl,
      };
}
