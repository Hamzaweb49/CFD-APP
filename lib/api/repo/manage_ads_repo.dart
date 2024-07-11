import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

class AdsRepo {
  /// Gadget By Guid ==========================================================

  static Future<ResponseItem> getGadgetByGuidRepo(
      {required String tableRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getGadgetByGuid}?tabRefGuid=$tableRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// Vehicle By Guid ==========================================================

  static Future<ResponseItem> getVehicleByGuidRepo(
      {required String tableRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getVehicleByGuid}?tabRefGuid=$tableRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// Property By Guid ==========================================================

  static Future<ResponseItem> getPropertyByGuidRepo(
      {required String tableRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getPropertyByGuid}?tabRefGuid=$tableRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// Jobs By Guid ==========================================================

  static Future<ResponseItem> getJobsByGuidRepo(
      {required String tableRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getJobByGuid}?tabRefGuid=$tableRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// Electronics By Guid ==========================================================

  static Future<ResponseItem> getElectronicsByGuidRepo(
      {required String tableRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getElectricApplianceByGuid}?tabRefGuid=$tableRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// Furniture By Guid ==========================================================

  static Future<ResponseItem> getFurnitureByGuidRepo(
      {required String tableRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getFurnitureByGuid}?tabletabRefGuid=$tableRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// Books By Guid ==========================================================

  static Future<ResponseItem> getBooksByGuidRepo(
      {required String tableRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getBookByGuid}?tabRefGuid=$tableRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// Sports By Guid ==========================================================

  static Future<ResponseItem> getSportsByGuidRepo(
      {required String tableRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getSportByGuid}?tabRefGuid=$tableRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// Pets By Guid ==========================================================

  static Future<ResponseItem> getPetsByGuidRepo(
      {required String tableRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getPetByGuid}?tabRefGuid=$tableRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// Fashion By Guid ==========================================================

  static Future<ResponseItem> getFashionByGuidRepo(
      {required String tableRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getFashionByGuid}?tabRefGuid=$tableRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }

  /// Commercial By Guid ==========================================================

  static Future<ResponseItem> getCommercialByGuidRepo(
      {required String tableRefGuid}) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        '${AppUrls.BASE_URL + MethodNames.getCommercialServiceByGuid}?tabRefGuid=$tableRefGuid';
    result = await BaseApiHelper.getRequest(requestUrl);
    return result;
  }
}

/// Delete Api
class AdsDelete {
  ///Gadgets Delete
  static Future<ResponseItem> deleteProduct(
      {required String deleteId, required int categoryId}) async {
    ResponseItem result = ResponseItem();
    String requestUrl = '';
    if (categoryId == 1) {
      requestUrl = '${AppUrls.BASE_URL + MethodNames.gadgetsDelete}$deleteId';
    } else if (categoryId == 2) {
      requestUrl = '${AppUrls.BASE_URL + MethodNames.vehicleDelete}$deleteId';
    } else if (categoryId == 3) {
      requestUrl = '${AppUrls.BASE_URL + MethodNames.propertyDelete}$deleteId';
    } else if (categoryId == 4) {
      requestUrl = '${AppUrls.BASE_URL + MethodNames.jobDelete}$deleteId';
    } else if (categoryId == 5) {
      requestUrl =
          '${AppUrls.BASE_URL + MethodNames.electricApplianceDelete}$deleteId';
    } else if (categoryId == 6) {
      requestUrl = '${AppUrls.BASE_URL + MethodNames.furnitureDelete}$deleteId';
    } else if (categoryId == 7) {
      requestUrl = '${AppUrls.BASE_URL + MethodNames.bookDelete}$deleteId';
    } else if (categoryId == 8) {
      requestUrl = '${AppUrls.BASE_URL + MethodNames.sportDelete}$deleteId';
    } else if (categoryId == 9) {
      requestUrl = '${AppUrls.BASE_URL + MethodNames.petDelete}$deleteId';
    } else if (categoryId == 10) {
      requestUrl = '${AppUrls.BASE_URL + MethodNames.fashionDelete}$deleteId';
    } else if (categoryId == 11) {
      requestUrl =
          '${AppUrls.BASE_URL + MethodNames.commercialServiceDelete}$deleteId';
    }
    result = await BaseApiHelper.deleteRequest(requestUrl);
    return result;
  }
}
