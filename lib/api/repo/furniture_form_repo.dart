import 'dart:io';

import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

/// Add Gadget
class AddFurnitureRepo {
  static Future<ResponseItem> addFurnitureRepo(
      {required Map<String, dynamic> furnitureData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.addFurniture;
    result = await BaseApiHelper.postRequest(requestUrl, furnitureData);
    return result;
  }
}

/// Upload Images
class UploadImageRepo {
  static Future<ResponseItem> uploadImagesRepo(
      {required List<File> requestData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.uploadFurnitureImage;
    result = await BaseApiHelper.uploadImages(
        requestUrl: requestUrl, requestData: requestData);
    return result;
  }
}

/// Upload Images
class PincodeRepo {
  static Future<ResponseItem> pincodeRepo({required String? pincode}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.PINCODE_URL + pincode!;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET ALL FURNITURE DATA
class GetAllFurnitureData {
  static Future<ResponseItem> getAllFurnitureData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllFurniture;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///put Furniture data
class UpdateFurnitureData {
  static Future<ResponseItem> updateFurnitureData(
      {required Map<String, dynamic> updateData, required String id}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = "${AppUrls.BASE_URL}${MethodNames.updateFurniture}$id";
    result = await BaseApiHelper.putRequest(requestUrl, updateData);
    return result;
  }
}
