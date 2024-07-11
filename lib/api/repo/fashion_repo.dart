import 'dart:io';

import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

class FashionRepo {
  /// add data

  static Future<ResponseItem> addFashionRepo(
      {required Map<String, dynamic> fashion}) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.addFashion;
    result = await BaseApiHelper.postRequest(requestUrl, fashion);
    return result;
  }

  /// GET ALL FASHION

  static Future<ResponseItem> getAllFashionRepo() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllFashion;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// upload image

  static Future<ResponseItem> uploadImagesRepo(
      {required List<File> requestData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.uploadFashionImage;
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

///put Fashion data
class UpdateFashionData {
  static Future<ResponseItem> updateFashionData(
      {required Map<String, dynamic> updateData, required String id}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = "${AppUrls.BASE_URL}${MethodNames.updateFashion}$id";
    result = await BaseApiHelper.putRequest(requestUrl, updateData);
    return result;
  }
}
