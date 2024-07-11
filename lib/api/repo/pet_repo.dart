import 'dart:io';

import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

class PetRepo {
  /// add data

  static Future<ResponseItem> addPetRepo(
      {required Map<String, dynamic> pet}) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.addPet;
    result = await BaseApiHelper.postRequest(requestUrl, pet);
    return result;
  }

  /// GET ALL PET

  static Future<ResponseItem> getAllPetRepo() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllPet;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// upload image

  static Future<ResponseItem> uploadImagesRepo(
      {required List<File> requestData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.uploadPetImage;
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

///put Pets data
class UpdatePetData {
  static Future<ResponseItem> updatePetData(
      {required Map<String, dynamic> updateData, required String id}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = "${AppUrls.BASE_URL}${MethodNames.updatePets}$id";
    result = await BaseApiHelper.putRequest(requestUrl, updateData);
    return result;
  }
}
