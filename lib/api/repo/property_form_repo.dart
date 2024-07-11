import 'dart:io';
import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

///add Property
class AddPropertyRepo {
  static Future<ResponseItem> addPropertyRepo(
      {required Map<String, dynamic> propertyData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.addPropertyData;
    result = await BaseApiHelper.postRequest(requestUrl, propertyData);
    return result;
  }
}

/// Upload Images
class UploadImagePropertyRepo {
  static Future<ResponseItem> uploadImagesPropertyRepo(
      {required List<File> requestData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.uploadPropertyImage;
    result = await BaseApiHelper.uploadImages(
        requestUrl: requestUrl, requestData: requestData);
    return result;
  }
}

///GET ALL PROPERTY DATA
class GetAllPropertyData {
  static Future<ResponseItem> getAllPropertyData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllPropertyData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///put Properties data
class UpdatePropertiesData {
  static Future<ResponseItem> updatePropertiesData(
      {required Map<String, dynamic> updateData, required String id}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = "${AppUrls.BASE_URL}${MethodNames.updateProperty}$id";
    result = await BaseApiHelper.putRequest(requestUrl, updateData);
    return result;
  }
}
