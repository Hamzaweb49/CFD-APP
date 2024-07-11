import 'dart:io';

import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

///add Property
class AddJobsRepo {
  static Future<ResponseItem> addJobsRepo(
      {required Map<String, dynamic> jobsData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.addJobs;
    result = await BaseApiHelper.postRequest(requestUrl, jobsData);
    return result;
  }
}

/// Upload Images
class UploadImageJobsRepo {
  static Future<ResponseItem> uploadImagesJobsRepo(
      {required List<File> requestData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.uploadJobsImage;
    result = await BaseApiHelper.uploadImages(
        requestUrl: requestUrl, requestData: requestData);
    return result;
  }
}

///GET ALL Jobs DATA
class GetAllJobsData {
  static Future<ResponseItem> getAllJobsData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllJobsData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///put Job data
class UpdateJobData {
  static Future<ResponseItem> updateJobData(
      {required Map<String, dynamic> updateData, required String id}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = "${AppUrls.BASE_URL}${MethodNames.updateJob}$id";
    result = await BaseApiHelper.putRequest(requestUrl, updateData);
    return result;
  }
}
