// To parse this JSON data, do
//
//     final postLoginOtpResponseModel = postLoginOtpResponseModelFromJson(jsonString);

import 'dart:convert';

UserLoginOtpResponseModel postLoginOtpResponseModelFromJson(String str) =>
    UserLoginOtpResponseModel.fromJson(json.decode(str));

String postLoginOtpResponseModelToJson(UserLoginOtpResponseModel data) =>
    json.encode(data.toJson());

class UserLoginOtpResponseModel {
  int? id;
  String? authToken;
  String? userId;
  String? firstName;
  dynamic lastName;
  String? role;
  String? mobileNumber;
  bool? isActiveUser;
  dynamic watsAppNumber;
  dynamic email;
  bool? isBlockedUser;

  UserLoginOtpResponseModel({
    this.id,
    this.authToken,
    this.userId,
    this.firstName,
    this.lastName,
    this.role,
    this.mobileNumber,
    this.isActiveUser,
    this.watsAppNumber,
    this.email,
    this.isBlockedUser,
  });

  factory UserLoginOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      UserLoginOtpResponseModel(
        id: json["id"],
        authToken: json["authToken"],
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        role: json["role"],
        mobileNumber: json["mobileNumber"],
        isActiveUser: json["isActiveUser"],
        watsAppNumber: json["watsAppNumber"],
        email: json["email"],
        isBlockedUser: json["isBlockedUser"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "authToken": authToken,
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
        "mobileNumber": mobileNumber,
        "isActiveUser": isActiveUser,
        "watsAppNumber": watsAppNumber,
        "email": email,
        "isBlockedUser": isBlockedUser,
      };
}
