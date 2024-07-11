import 'dart:io';

import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

class SportsRepo {
  /// add data

  static Future<ResponseItem> addSportsRepo(
      {required Map<String, dynamic> sports}) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.addSports;
    result = await BaseApiHelper.postRequest(requestUrl, sports);
    return result;
  }

  /// GET ALL PET

  static Future<ResponseItem> getAllSportsRepo() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllSports;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// upload image

  static Future<ResponseItem> uploadImagesRepo(
      {required List<File> requestData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.uploadSportsImage;
    result = await BaseApiHelper.uploadImages(
        requestUrl: requestUrl, requestData: requestData);
    return result;
  }

  /// pincode data

  static Future<ResponseItem> pincodeRepo({required String? pincode}) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.PINCODE_URL + pincode!;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///put Sports data
class UpdateSportsData {
  static Future<ResponseItem> updateSportsData(
      {required Map<String, dynamic> updateData, required String id}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = "${AppUrls.BASE_URL}${MethodNames.updateSports}$id";
    result = await BaseApiHelper.putRequest(requestUrl, updateData);
    return result;
  }
}
