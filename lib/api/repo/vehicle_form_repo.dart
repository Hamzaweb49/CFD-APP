import 'dart:io';

import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

/// Add Gadget
class AddVehicleRepo {
  static Future<ResponseItem> addVehicleRepo(
      {required Map<String, dynamic> vehicleData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.addVehicle;
    result = await BaseApiHelper.postRequest(requestUrl, vehicleData);
    return result;
  }
}

///GET ALL VEHICLE DATA
class GetAllVehicleData {
  static Future<ResponseItem> getAllVehicleData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllVehicleData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///Upload Image Vehicle
class UploadImageVehicleRepo {
  static Future<ResponseItem> uploadImagesVehicleRepo(
      {required List<File> requestData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.uploadVehicleImage;
    result = await BaseApiHelper.uploadImages(
        requestUrl: requestUrl, requestData: requestData);
    return result;
  }
}

///GET CAR Brand  DATA
class GetCarBrandData {
  static Future<ResponseItem> getCarBrandData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getCarBrandData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET CAR MODEL  DATA
class GetCarModelData {
  static Future<ResponseItem> getCarModelData(String id) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getCarModelData + id;

    print('--requestUrl--->>>>>$requestUrl');
    result = await BaseApiHelper.getRequest(requestUrl);
    print('--result--->>>>>$result');
    return result;
  }
}

///GET BIKE BRAND  DATA
class GetBikeBrandData {
  static Future<ResponseItem> getBikeBrandData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getBikeBrandData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET Bike MODEL  DATA
class GetBikeModelData {
  static Future<ResponseItem> getBikeModelData(String id) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getBikeModelData + id;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET SCOOTY BRAND  DATA
class GetScootyBrandData {
  static Future<ResponseItem> getScootyBrandData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getScootyBrandData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET BICYCLE BRAND  DATA
class GetBicycleBrandData {
  static Future<ResponseItem> getBicycleBrandData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getBicycleBrandData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///put Vehicles data
class UpdateVehiclesData {
  static Future<ResponseItem> updateVehiclesData(
      {required Map<String, dynamic> updateData, required String id}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = "${AppUrls.BASE_URL}${MethodNames.updateVehicles}$id";
    result = await BaseApiHelper.putRequest(requestUrl, updateData);
    return result;
  }
}
