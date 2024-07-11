import 'dart:io';

import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

/// Add Gadget
class AddBookRepo {
  static Future<ResponseItem> addBookRepo(
      {required Map<String, dynamic> bookData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.addBook;
    result = await BaseApiHelper.postRequest(requestUrl, bookData);
    return result;
  }
}

/// Upload Images
class UploadImageRepo {
  static Future<ResponseItem> uploadImagesRepo(
      {required List<File> requestData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.uploadBookImage;
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

///GET ALL Book DATA
class GetAllBookData {
  static Future<ResponseItem> getAllBookData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllBook;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///put book data
class PutBookData {
  static Future<ResponseItem> updateBookData(
      {required Map<String, dynamic> updateData, required String id}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = "${AppUrls.BASE_URL}${MethodNames.updateBook}$id";
    result = await BaseApiHelper.putRequest(requestUrl, updateData);
    return result;
  }
}
