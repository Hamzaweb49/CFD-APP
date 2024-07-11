import 'dart:developer';
import 'package:claxified_app/api/repo/home_screen_repo.dart';
import 'package:claxified_app/api/repo/manage_ads_repo.dart';
import 'package:claxified_app/api/repo/profile_screen_repo.dart';
import 'package:claxified_app/model/get_all_ads_response_model.dart';
import 'package:claxified_app/model/get_all_category_response_model.dart';
import 'package:claxified_app/model/get_all_wishlist_response_model.dart';
import 'package:claxified_app/model/get_dashboard_byguid_response_model.dart';
import 'package:claxified_app/model/get_dashboard_data_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_all_electronics_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_book_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_commercial_services_res_model.dart';
import 'package:claxified_app/model/product_list_model/get_fashion_data_res_model.dart';
import 'package:claxified_app/model/product_list_model/get_furniture_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_gadget_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_jobs_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_pet_data_res_model.dart';
import 'package:claxified_app/model/product_list_model/get_property_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_sports_data_res_model.dart';
import 'package:claxified_app/model/product_list_model/get_vehicle_response_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/model/sub_category_response_model.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/utils/app_routes.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {
  int selected = 0;
  RxBool isLoading = false.obs;
  SubCategoryResponseModel? subCategoryData;
  List pendingEditList = ["Edit", "Delete"];

  ///GET Ads DATA
  List<GetAllAdsResponseModel> getAllAdsResponseModel = [];

  getAllAdsData(String id) async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetAllProfileData.getAllAdsData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getAllAdsResponseModel = List<GetAllAdsResponseModel>.from(
              result.data.map((x) => GetAllAdsResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR==getAllAdsData=====>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///get all category
  List<GetAllCategoryResponseModel>? getAllCategoryResponseModel;

  getAllCategory() async {
    ResponseItem result;
    result = await GetAllCategoryRepo.getAllCategoryRepo();
    try {
      if (result.status) {
        if (result.data != null) {
          getAllCategoryResponseModel = List<GetAllCategoryResponseModel>.from(
              result.data.map((x) => GetAllCategoryResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('=====E====>>>$e');
    }
    update();
  }

  ///sub category
  List<SubCategoryResponseModel>? subCategoryResponseModel;

  getAllSubcategoryData(int id) async {
    ResponseItem result;
    result = await GetSubCategoryRepo.getSubCategoryRepo(id: id);
    try {
      if (result.status) {
        if (result.data != null) {
          subCategoryResponseModel = List<SubCategoryResponseModel>.from(
              result.data.map((x) => SubCategoryResponseModel.fromJson(x)));
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====selectedCategory==>>>>====>>>>$e');
    }
    update();
  }

  /// Edit Button Function ===============================================================
  int categoryId = 0;

  /// All Form Details screen Function ===============================================================

  openForm(GetAllAdsResponseModel getAllAdsResponseModel) async {
    categoryId = getAllAdsResponseModel.categoryId ?? 0;

    /// SUB CATEGORY API
    await getAllSubcategoryData(getAllAdsResponseModel.categoryId!);

    /// GUID API ROUTES
    await guidApiRoutes(getAllAdsResponseModel.categoryId!,
        getAllAdsResponseModel.tableRefGuid.toString(), 'EditScreen');
  }

  /// Ads Details screen Function ===============================================================
  openAdsDetailsScreen(GetAllAdsResponseModel getAllAdsResponseModel) async {
    await getAllSubcategoryData(getAllAdsResponseModel.categoryId!);

    /// GUID API ROUTES
    await guidApiRoutes(getAllAdsResponseModel.categoryId!,
        getAllAdsResponseModel.tableRefGuid.toString(), "detailScreen");
  }

  /// DashBoard Details screen Function ===============================================================
  openDashBoardDetailsScreen(
      GetAllDashboardDataResponseModel getAllDashboardDataResponseModel) async {
    await getAllSubcategoryData(getAllDashboardDataResponseModel.categoryId!);

    /// GUID API ROUTES
    await guidApiRoutes(
        getAllDashboardDataResponseModel.categoryId!,
        getAllDashboardDataResponseModel.tableRefGuid.toString(),
        "detailScreen");
  }

  /// WishList Details screen Function ===============================================================
  openWishListDetailsScreen(
      GetAllDashBoardByGuidModel getAllDashBoardByGuidModel) async {
    await getAllSubcategoryData(getAllDashBoardByGuidModel.categoryId!);

    /// GUID API ROUTES
    await guidApiRoutes(getAllDashBoardByGuidModel.categoryId!,
        getAllDashBoardByGuidModel.tableRefGuid.toString(), "detailScreen");
  }

  /// GUID API ROUTES FUNCTION =============================================================
  guidApiRoutes(int categoryId, String tableRefGuid, String detailsKey) async {
    if (categoryId == 1) {
      await getGadgetByGuid(tableRefGuid: tableRefGuid.toString());
      if (detailsKey == "EditScreen") {
        await getSubcategoryDetails(
            getAllGadgetResponseModel[0].subCategoryId ?? 0);

        Get.toNamed(_getRouteName(), arguments: {
          'SubCategory': subCategoryData,
          'ModelData': getAllGadgetResponseModel,
          'isFrom': 'EditScreen'
        });
      } else {
        Get.toNamed(Routes.gadgetDetailsScreen,
            arguments: getAllGadgetResponseModel[0]);
      }
    } else if (categoryId == 2) {
      await getVehicleByGuid(tableRefGuid: tableRefGuid.toString());
      if (detailsKey == "EditScreen") {
        await getSubcategoryDetails(
            getAllVehicleResponseModel[0].subCategoryId ?? 0);
        Get.toNamed(_getRouteName(), arguments: {
          'SubCategory': subCategoryData,
          'ModelData': getAllVehicleResponseModel,
          'isFrom': 'EditScreen',
        });
      } else {
        Get.toNamed(Routes.vehicleDetailsScreen,
            arguments: getAllVehicleResponseModel[0]);
      }
    } else if (categoryId == 3) {
      await getPropertyByGuid(tableRefGuid: tableRefGuid.toString());
      if (detailsKey == "EditScreen") {
        await getSubcategoryDetails(
            getAllPropertyResponseModel[0].subCategoryId ?? 0);
        Get.toNamed(_getRouteName(), arguments: {
          'SubCategory': subCategoryData,
          'ModelData': getAllPropertyResponseModel,
          'isFrom': 'EditScreen'
        });
      } else {
        await getSubcategoryDetails(
            getAllPropertyResponseModel[0].subCategoryId ?? 0);
        Get.toNamed(Routes.propertiesDetailsScreen, arguments: {
          'subcategory': subCategoryData,
          'product': getAllPropertyResponseModel[0],
        });
      }
    } else if (categoryId == 4) {
      await getJobsByGuid(tableRefGuid: tableRefGuid.toString());

      if (detailsKey == "EditScreen") {
        await getSubcategoryDetails(
            getAllJobsResponseModel[0].subCategoryId ?? 0);

        Get.toNamed(_getRouteName(), arguments: {
          'SubCategory': subCategoryData,
          'ModelData': getAllJobsResponseModel,
          'isFrom': 'EditScreen'
        });
      } else {
        Get.toNamed(Routes.jobsDetailsScreen,
            arguments: getAllJobsResponseModel[0]);
      }
    } else if (categoryId == 5) {
      await getElectronicsByGuid(tableRefGuid: tableRefGuid.toString());

      if (detailsKey == "EditScreen") {
        await getSubcategoryDetails(
            getAllElectronicsResponseModel[0].subCategoryId ?? 0);
        Get.toNamed(_getRouteName(), arguments: {
          'SubCategory': subCategoryData,
          'ModelData': getAllElectronicsResponseModel,
          'isFrom': 'EditScreen'
        });
      } else {
        Get.toNamed(Routes.electronicsDetailsScreen,
            arguments: getAllElectronicsResponseModel[0]);
      }
    } else if (categoryId == 6) {
      await getFurnitureByGuid(tableRefGuid: tableRefGuid.toString());
      if (detailsKey == "EditScreen") {
        await getSubcategoryDetails(
            getFurnitureResponseModel[0].subCategoryId ?? 0);

        Get.toNamed(_getRouteName(), arguments: {
          'SubCategory': subCategoryData,
          'ModelData': getFurnitureResponseModel,
          'isFrom': 'EditScreen'
        });
      } else {
        Get.toNamed(Routes.furnitureDetailsScreen,
            arguments: getFurnitureResponseModel[0]);
      }
    } else if (categoryId == 7) {
      await getBooksByGuid(tableRefGuid: tableRefGuid.toString());

      if (detailsKey == "EditScreen") {
        await getSubcategoryDetails(
            getAllBooksResponseModel[0].subCategoryId ?? 0);

        Get.toNamed(_getRouteName(), arguments: {
          'SubCategory': subCategoryData,
          'ModelData': getAllBooksResponseModel,
          'isFrom': 'EditScreen'
        });
      } else {
        Get.toNamed(Routes.bookDetailsScreen,
            arguments: getAllBooksResponseModel[0]);
      }
    } else if (categoryId == 8) {
      await getSportsByGuid(tableRefGuid: tableRefGuid.toString());

      if (detailsKey == "EditScreen") {
        await getSubcategoryDetails(
            getAllSportsDataResponseModel[0].subCategoryId ?? 0);

        Get.toNamed(_getRouteName(), arguments: {
          'SubCategory': subCategoryData,
          'ModelData': getAllSportsDataResponseModel,
          'isFrom': 'EditScreen'
        });
      } else {
        Get.toNamed(Routes.sportsDetailsScreen,
            arguments: getAllSportsDataResponseModel[0]);
      }
    } else if (categoryId == 9) {
      await getPetByGuid(tableRefGuid: tableRefGuid.toString());

      if (detailsKey == "EditScreen") {
        await getSubcategoryDetails(
            getAllPetDataResponseModel[0].subCategoryId ?? 0);

        Get.toNamed(_getRouteName(), arguments: {
          'SubCategory': subCategoryData,
          'ModelData': getAllPetDataResponseModel,
          'isFrom': 'EditScreen'
        });
      } else {
        Get.toNamed(Routes.petDetailsScreen,
            arguments: getAllPetDataResponseModel[0]);
      }
    } else if (categoryId == 10) {
      await getFashionByGuid(tableRefGuid: tableRefGuid.toString());

      if (detailsKey == "EditScreen") {
        await getSubcategoryDetails(
            getAllFashionDataResponseModel[0].subCategoryId ?? 0);

        Get.toNamed(_getRouteName(), arguments: {
          'SubCategory': subCategoryData,
          'ModelData': getAllFashionDataResponseModel,
          'isFrom': 'EditScreen'
        });
      } else {
        Get.toNamed(Routes.fashionDetailsScreen,
            arguments: getAllFashionDataResponseModel[0]);
      }
    } else if (categoryId == 11) {
      await getCommercialByGuid(tableRefGuid: tableRefGuid.toString());

      if (detailsKey == "EditScreen") {
        await getSubcategoryDetails(
            getAllCommercialServicesResponseModel[0].subCategoryId ?? 0);

        Get.toNamed(_getRouteName(), arguments: {
          'SubCategory': subCategoryData,
          'ModelData': getAllCommercialServicesResponseModel,
          'isFrom': 'EditScreen'
        });
      } else {
        Get.toNamed(Routes.commercialServicesDetailsScreen,
            arguments: getAllCommercialServicesResponseModel[0]);
      }
    }
  }

  /// FIND SUB CATEGORY
  getSubcategoryDetails(int subcategoryId) {
    for (var element in subCategoryResponseModel!) {
      if (element.id == subcategoryId) {
        subCategoryData = element;
        break;
      }
    }
    update();
  }

  /// CHANGE ROUTE
  String _getRouteName() {
    switch (categoryId) {
      case 1:
        return Routes.gadgetFormScreen;
      case 2:
        return Routes.vehicleFormScreen;
      case 3:
        return Routes.propertiesFormScreen;
      case 4:
        return Routes.jobsFormScreen;
      case 5:
        return Routes.electronicsFormScreen;
      case 6:
        return Routes.furnitureFormScreen;
      case 7:
        return Routes.bookFormScreen;
      case 8:
        return Routes.sportsFormScreen;
      case 9:
        return Routes.petFormScreen;
      case 10:
        return Routes.fashionFormScreen;
      case 11:
        return Routes.commercialServicesFormScreen;
      default:
        return Routes.jobsFormScreen;
    }
  }

  /// --------------------------------------GET GUID DATA START --------------------------------------------------------------------

  /// Get Gadget By Guid =====================================================

  List<GetAllGadgetResponseModel> getAllGadgetResponseModel = [];

  getGadgetByGuid({required String tableRefGuid}) async {
    ResponseItem result;
    result = await AdsRepo.getGadgetByGuidRepo(tableRefGuid: tableRefGuid);
    try {
      if (result.status) {
        if (result.data != null) {
          getAllGadgetResponseModel = List<GetAllGadgetResponseModel>.from(
              result.data.map((x) => GetAllGadgetResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====Get GadgetBy Guid Repo==>>>>====>>>>$e');
    }
    update();
  }

  /// Get Vehicle By Guid ===============================================================

  List<GetAllVehicleResponseModel> getAllVehicleResponseModel = [];

  getVehicleByGuid({required String tableRefGuid}) async {
    ResponseItem result;
    result = await AdsRepo.getVehicleByGuidRepo(tableRefGuid: tableRefGuid);
    try {
      if (result.status) {
        if (result.data != null) {
          getAllVehicleResponseModel = List<GetAllVehicleResponseModel>.from(
              result.data.map((x) => GetAllVehicleResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====GetAllVehicleResponseModel==>>>>====>>>>$e');
    }
    update();
  }

  /// Get Property By Guid ===============================================================

  List<GetAllPropertyResponseModel> getAllPropertyResponseModel = [];

  getPropertyByGuid({required String tableRefGuid}) async {
    ResponseItem result;
    result = await AdsRepo.getPropertyByGuidRepo(tableRefGuid: tableRefGuid);
    try {
      if (result.status) {
        if (result.data != null) {
          getAllPropertyResponseModel = List<GetAllPropertyResponseModel>.from(
              result.data.map((x) => GetAllPropertyResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====getGadgetByGuidRepo==>>>>====>>>>$e');
    }
    update();
  }

  /// Get Job By Guid ===============================================================

  List<GetJobsResponseModel> getAllJobsResponseModel = [];

  getJobsByGuid({required String tableRefGuid}) async {
    ResponseItem result;
    result = await AdsRepo.getJobsByGuidRepo(tableRefGuid: tableRefGuid);
    try {
      if (result.status) {
        if (result.data != null) {
          getAllJobsResponseModel = List<GetJobsResponseModel>.from(
              result.data.map((x) => GetJobsResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====GetJobsResponseModel==>>>>====>>>>$e');
    }
    update();
  }

  /// Get Electronics By Guid ===============================================================

  List<GetAllElectronicsResponseModel> getAllElectronicsResponseModel = [];

  getElectronicsByGuid({required String tableRefGuid}) async {
    ResponseItem result;
    result = await AdsRepo.getElectronicsByGuidRepo(tableRefGuid: tableRefGuid);
    try {
      if (result.status) {
        if (result.data != null) {
          getAllElectronicsResponseModel =
              List<GetAllElectronicsResponseModel>.from(result.data
                  .map((x) => GetAllElectronicsResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====GetAllElectronicsResponseModel==>>>>====>>>>$e');
    }
    update();
  }

  /// Get Furniture By Guid ===============================================================

  List<GetFurnitureResponseModel> getFurnitureResponseModel = [];

  getFurnitureByGuid({required String tableRefGuid}) async {
    ResponseItem result;
    result = await AdsRepo.getFurnitureByGuidRepo(tableRefGuid: tableRefGuid);
    try {
      if (result.status) {
        if (result.data != null) {
          getFurnitureResponseModel = List<GetFurnitureResponseModel>.from(
              result.data.map((x) => GetFurnitureResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====GetFurnitureResponseModel==>>>>====>>>>$e');
    }
    update();
  }

  /// Get Books By Guid ===============================================================

  List<GetBookResponseModel> getAllBooksResponseModel = [];

  getBooksByGuid({required String tableRefGuid}) async {
    ResponseItem result;
    result = await AdsRepo.getBooksByGuidRepo(tableRefGuid: tableRefGuid);
    try {
      if (result.status) {
        if (result.data != null) {
          getAllBooksResponseModel = List<GetBookResponseModel>.from(
              result.data.map((x) => GetBookResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====GetBookResponseModel==>>>>====>>>>$e');
    }
    update();
  }

  /// Get Sports By Guid ===============================================================

  List<GetAllSportsDataResponseModel> getAllSportsDataResponseModel = [];

  getSportsByGuid({required String tableRefGuid}) async {
    ResponseItem result;
    result = await AdsRepo.getSportsByGuidRepo(tableRefGuid: tableRefGuid);
    try {
      if (result.status) {
        if (result.data != null) {
          getAllSportsDataResponseModel =
              List<GetAllSportsDataResponseModel>.from(result.data
                  .map((x) => GetAllSportsDataResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====GetAllSportsDataResponseModel==>>>>====>>>>$e');
    }
    update();
  }

  /// Get Pets By Guid ===============================================================

  List<GetAllPetDataResponseModel> getAllPetDataResponseModel = [];

  getPetByGuid({required String tableRefGuid}) async {
    ResponseItem result;
    result = await AdsRepo.getPetsByGuidRepo(tableRefGuid: tableRefGuid);
    try {
      if (result.status) {
        if (result.data != null) {
          getAllPetDataResponseModel = List<GetAllPetDataResponseModel>.from(
              result.data.map((x) => GetAllPetDataResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====GetAllPetDataResponseModel==>>>>====>>>>$e');
    }
    update();
  }

  /// Get Fashion By Guid ===============================================================

  List<GetAllFashionDataResponseModel> getAllFashionDataResponseModel = [];

  getFashionByGuid({required String tableRefGuid}) async {
    ResponseItem result;
    result = await AdsRepo.getFashionByGuidRepo(tableRefGuid: tableRefGuid);
    try {
      if (result.status) {
        if (result.data != null) {
          getAllFashionDataResponseModel =
              List<GetAllFashionDataResponseModel>.from(result.data
                  .map((x) => GetAllFashionDataResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====GetAllFashionDataResponseModel==>>>>====>>>>$e');
    }
    update();
  }

  /// Get Commercial By Guid ===============================================================

  List<GetAllCommercialServicesResponseModel>
      getAllCommercialServicesResponseModel = [];

  getCommercialByGuid({required String tableRefGuid}) async {
    ResponseItem result;
    result = await AdsRepo.getCommercialByGuidRepo(tableRefGuid: tableRefGuid);
    try {
      if (result.status) {
        if (result.data != null) {
          getAllCommercialServicesResponseModel =
              List<GetAllCommercialServicesResponseModel>.from(result.data.map(
                  (x) => GetAllCommercialServicesResponseModel.fromJson(x)));

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
      }
    } catch (e) {
      log('ERROR=====GetAllCommercialServicesResponseModel==>>>>====>>>>$e');
    }
    update();
  }

  /// ---------------------------------------------- GET GUID DATA END --------------------------------------------------------------------
  String image = '';

  String manageAdsImage(int index) {
    if (getAllAdsResponseModel[index].categoryId == 1) {
      if (getAllAdsResponseModel[index].gadgetImageList.isNotEmpty) {
        image = getAllAdsResponseModel[index].gadgetImageList[0].imageUrl ?? '';
      } else {
        image = '';
      }
    } else if (getAllAdsResponseModel[index].categoryId == 2) {
      if (getAllAdsResponseModel[index].vehicleImageList.isNotEmpty) {
        image =
            getAllAdsResponseModel[index].vehicleImageList[0].imageUrl ?? '';
      } else {
        image = '';
      }
    } else if (getAllAdsResponseModel[index].categoryId == 3) {
      if (getAllAdsResponseModel[index].propertyImageList.isNotEmpty) {
        image =
            getAllAdsResponseModel[index].propertyImageList[0].imageUrl ?? '';
      } else {
        image = '';
      }
    } else if (getAllAdsResponseModel[index].categoryId == 4) {
      if (getAllAdsResponseModel[index].jobImageList.isNotEmpty) {
        image = getAllAdsResponseModel[index].jobImageList[0].imageUrl ?? '';
      } else {
        image = '';
      }
    } else if (getAllAdsResponseModel[index].categoryId == 5) {
      if (getAllAdsResponseModel[index]
          .electronicApplianceImageList
          .isNotEmpty) {
        image = getAllAdsResponseModel[index]
                .electronicApplianceImageList[0]
                .imageUrl ??
            '';
      } else {
        image = '';
      }
    } else if (getAllAdsResponseModel[index].categoryId == 6) {
      if (getAllAdsResponseModel[index].furnitureImageList.isNotEmpty) {
        image =
            getAllAdsResponseModel[index].furnitureImageList[0].imageUrl ?? '';
      } else {
        image = '';
      }
    } else if (getAllAdsResponseModel[index].categoryId == 7) {
      if (getAllAdsResponseModel[index].bookImageList.isNotEmpty) {
        image = getAllAdsResponseModel[index].bookImageList[0].imageUrl ?? '';
      } else {
        image = '';
      }
    } else if (getAllAdsResponseModel[index].categoryId == 8) {
      if (getAllAdsResponseModel[index].sportImageList.isNotEmpty) {
        image = getAllAdsResponseModel[index].sportImageList[0].imageUrl ?? '';
      } else {
        image = '';
      }
    } else if (getAllAdsResponseModel[index].categoryId == 9) {
      if (getAllAdsResponseModel[index].petImageList.isNotEmpty) {
        image = getAllAdsResponseModel[index].petImageList[0].imageUrl ?? '';
      } else {
        image = '';
      }
    } else if (getAllAdsResponseModel[index].categoryId == 10) {
      if (getAllAdsResponseModel[index].fashionImageList.isNotEmpty) {
        image =
            getAllAdsResponseModel[index].fashionImageList[0].imageUrl ?? '';
      } else {
        image = '';
      }
    } else if (getAllAdsResponseModel[index].categoryId == 11) {
      if (getAllAdsResponseModel[index].commercialServiceImageList.isNotEmpty) {
        log('-------->>>>${getAllAdsResponseModel[index].commercialServiceImageList[0]}');
        image = getAllAdsResponseModel[index]
                .commercialServiceImageList[0]
                .imageUrl ??
            '';
      } else {
        image = '';
      }
    } else {
      image = '';
    }
    return image;
  }

  deleteForm(GetAllAdsResponseModel getAllAdsResponseModel) async {
    await deleteAds(getAllAdsResponseModel.categoryId ?? 0,
        getAllAdsResponseModel.id.toString());
  }

  /// DELETE API ROUTES FUNCTION =============================================================

  deleteAds(int categoryId, String deleteId) async {
    await deleteProduct(deleteId: deleteId.toString(), categoryId: categoryId);
  }

  ///Delete Controller ------------------------------------
  deleteProduct({required String deleteId, required int categoryId}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await AdsDelete.deleteProduct(
        deleteId: deleteId, categoryId: categoryId);
    try {
      if (result.status == true) {
        showSuccessSnackBar('Delete Successfully');
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        showSuccessSnackBar('Something Went Wrong,Please Try Again');
      }
    } catch (e) {
      log('ERROR====Gadgets===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  /// dash board by guid Api

  getDashBoardByGuidData() async {
    await getAllWishListData(
        preferences.getInt(SharedPreference.userId).toString());
    wishListData = [];
    for (var element in getAllWishListResponseModel) {
      try {
        ResponseItem result;
        result = await GetAllProfileData.getDashBoardByGuidRepo(
            categoryId: element.categoryId.toString(),
            tabRefGuid: element.productId.toString());
        if (result.status) {
          if (result.data != null) {
            wishListData.add(GetAllDashBoardByGuidModel.fromJson(result.data));

            update();
          }
        } else {
          showBottomSnackBar(result.message!);
        }
      } catch (e) {
        log('ERROR=====getDashBoardByGuidData==>>>>====>>>>$e');
      }
    }
    update();
  }

  String images = '';
  String imageLength = '0';

  String wishListImage(int index) {
    if (wishListData[index].gadgetImageList.isNotEmpty) {
      images = wishListData[index].gadgetImageList[0].imageUrl ?? '';
      imageLength = wishListData[index].gadgetImageList.length.toString();
    } else if (wishListData[index].vehicleImageList.isNotEmpty) {
      images = wishListData[index].vehicleImageList[0].imageUrl ?? '';
      imageLength = wishListData[index].vehicleImageList.length.toString();
    } else if (wishListData[index].propertyImageList.isNotEmpty) {
      images = wishListData[index].propertyImageList[0].imageUrl ?? '';
      imageLength = wishListData[index].propertyImageList.length.toString();
    } else if (wishListData[index].jobImageList.isNotEmpty) {
      images = wishListData[index].jobImageList[0].imageUrl ?? '';
      imageLength = wishListData[index].jobImageList.length.toString();
    } else if (wishListData[index].electronicApplianceImageList.isNotEmpty) {
      images =
          wishListData[index].electronicApplianceImageList[0].imageUrl ?? '';
      imageLength =
          wishListData[index].electronicApplianceImageList.length.toString();
    } else if (wishListData[index].furnitureImageList.isNotEmpty) {
      images = wishListData[index].furnitureImageList[0].imageUrl ?? '';
      imageLength = wishListData[index].furnitureImageList.length.toString();
    } else if (wishListData[index].bookImageList.isNotEmpty) {
      images = wishListData[index].bookImageList[0].imageUrl ?? '';
      imageLength = wishListData[index].bookImageList.length.toString();
    } else if (wishListData[index].sportImageList.isNotEmpty) {
      images = wishListData[index].sportImageList[0].imageUrl ?? '';
      imageLength = wishListData[index].sportImageList.length.toString();
    } else if (wishListData[index].petImageList.isNotEmpty) {
      images = wishListData[index].petImageList[0].imageUrl ?? '';
      imageLength = wishListData[index].petImageList.length.toString();
    } else if (wishListData[index].fashionImageList.isNotEmpty) {
      images = wishListData[index].fashionImageList[0].imageUrl ?? '';
      imageLength = wishListData[index].fashionImageList.length.toString();
    } else if (wishListData[index].commercialServiceImageList.isNotEmpty) {
      images = wishListData[index].commercialServiceImageList[0].imageUrl ?? '';
      imageLength =
          wishListData[index].commercialServiceImageList.length.toString();
    } else {
      images = '';
      imageLength = '0';
    }
    return images;
  }

  /// Get All VishList Data

  List<GetAllWishListResponseModel> getAllWishListResponseModel = [];
  List<GetAllDashBoardByGuidModel> wishListData = [];

  Future getAllWishListData(String id) async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetAllProfileData.getAllWishListData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getAllWishListResponseModel = List<GetAllWishListResponseModel>.from(
              result.data.map((x) => GetAllWishListResponseModel.fromJson(x)));
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR==getAllWishListData=====>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  clearData() {
    selected = 0;
  }
}
