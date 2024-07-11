import 'dart:io';

import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

/// Add Electronics
class AddElectronicsRepo {
  static Future<ResponseItem> addElectronicsRepo(
      {required Map<String, dynamic> electronicsData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.addElectronicsData;
    result = await BaseApiHelper.postRequest(requestUrl, electronicsData);
    return result;
  }
}

/// Upload Images Electronics
class UploadElectronicsImageRepo {
  static Future<ResponseItem> uploadElectronicsImageRepo(
      {required List<File> requestData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.uploadElectronicsImage;
    result = await BaseApiHelper.uploadImages(
        requestUrl: requestUrl, requestData: requestData);
    return result;
  }
}

/// PinCode Electronics
class PinCodeRepo {
  static Future<ResponseItem> pinCodeRepo({required String? pinCode}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.PINCODE_URL + pinCode!;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET ALL Electronics DATA
class GetAllElectronicsData {
  static Future<ResponseItem> getAllElectronicsData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllElectronicsImage;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///put Electronics data
class UpdateElectronicsData {
  static Future<ResponseItem> updateElectronicsData(
      {required Map<String, dynamic> updateData, required String id}) async {
    ResponseItem result = ResponseItem();

    String requestUrl =
        "${AppUrls.BASE_URL}${MethodNames.updateElectricAppliance}$id";
    result = await BaseApiHelper.putRequest(requestUrl, updateData);
    return result;
  }
}
