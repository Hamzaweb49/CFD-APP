import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

class GetAllCategoryRepo {
  /// GET ALL CATEGORY

  static Future<ResponseItem> getAllCategoryRepo() async {
    ResponseItem result = ResponseItem();

    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllCategory;
    result = await BaseApiHelper.getRequest(requestUrl);

    return result;
  }
}

/// GET SUB CATEGORY
class GetSubCategoryRepo {
  static Future<ResponseItem> getSubCategoryRepo({required int id}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        AppUrls.BASE_URL + MethodNames.getSubCategory + id.toString();
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

/// GET DASHBOARD DATA
class GetAllDashBoardData {
  static Future<ResponseItem> getAllDashBoardData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllDashboardData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET ALL GADGETDATA
class GetAllGadgetData {
  static Future<ResponseItem> getAllGadgetData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getAllGadgetData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET STATE DATA
class GetStateData {
  static Future<ResponseItem> getStateData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getStateData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET City DATA
class GetCityData {
  static Future<ResponseItem> getCityData(String id) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getCityData + id;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET NEARBY DATA
class GetNearByData {
  static Future<ResponseItem> getNearByData(String id) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getNearByData + id;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET MOBILE BRAND DATA
class GetMobileBrandData {
  static Future<ResponseItem> getMobileBrandData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getMobileBrandData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///GET TABLET BRAND DATA
class GetTabletBrandData {
  static Future<ResponseItem> getTabletBrandData() async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.getTabletBrandData;
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

///add wishList

class AddWishListRepo {
  static Future<ResponseItem> addWishListRepo(
      {required Map<String, dynamic> wishListData}) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.addWishList;
    result = await BaseApiHelper.postRequest(requestUrl, wishListData);
    return result;
  }
}
