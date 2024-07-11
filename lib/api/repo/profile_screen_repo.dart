import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

class GetAllProfileData {
  static Future<ResponseItem> getAllAdsData(String id) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        "${AppUrls.BASE_URL}${MethodNames.getAllAds}?userId=$id";

    print('--requestUrl--->>>>>$requestUrl');
    result = await BaseApiHelper.getRequest(requestUrl);
    print('--result--->>>>>$result');
    return result;
  }

  static Future<ResponseItem> getAllWishListData(String id) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        "${AppUrls.BASE_URL}${MethodNames.getAllWishList}?userId=$id";

    print('--requestUrl--->>>>>$requestUrl');
    result = await BaseApiHelper.getRequest(requestUrl);
    print('--result--->>>>>$result');
    return result;
  }

  static Future<ResponseItem> getDashBoardByGuidRepo(
      {required String categoryId, required String tabRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getDashBoardByGuid}?categoryId=$categoryId&tabRefGuid=$tabRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  static Future<ResponseItem> addFeedBackRepo(
      {required Map<String, dynamic> feedBackData}) async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.addFeedBack;
    result = await BaseApiHelper.postRequest(requestUrl, feedBackData);
    return result;
  }
}
