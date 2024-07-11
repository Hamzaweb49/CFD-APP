import 'dart:io';

import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

/// Add Gadget
class AddGadgetRepo {
  static Future<ResponseItem> addGadgetRepo(
      {required Map<String, dynamic> gadgetData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.addGadget;
    result = await BaseApiHelper.postRequest(requestUrl, gadgetData);
    return result;
  }
}

/// Upload Images
class UploadImageRepo {
  static Future<ResponseItem> uploadImagesRepo(
      {required List<File> requestData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.uploadGadgetImage;
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

///put Gadget data
class UpdateGadgetData {
  static Future<ResponseItem> updateGadgetsData(
      {required Map<String, dynamic> gadgetData, required String id}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.updateGadgets + id;
    result = await BaseApiHelper.putRequest(requestUrl, gadgetData);
    return result;
  }
}
