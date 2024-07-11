import 'dart:developer';

import 'package:claxified_app/api/repo/commercial_services_repo.dart';
import 'package:claxified_app/model/product_list_model/get_commercial_services_res_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommercialServicesController extends GetxController {
  ProductScreenController productScreenController = Get.put(ProductScreenController());

  RxBool isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();

  ///productScreen
  List<int> likedData = [];

  addFavouriteData(int index) {
    if (likedData.contains(index)) {
      likedData.remove(index);
    } else {
      likedData.add(index);
    }
    update();
  }

  bool likeSelect = false;

  void selectLikeData() {
    likeSelect = !likeSelect;
    update();
  }

  int selectProductDetails = 0;

  void updateData(int index) {
    selectProductDetails = index;
    update();
  }

  /// GET ALL Comercial Services
  List<GetAllCommercialServicesResponseModel> getAllCommercialServicesResponseModel = [];
  List<GetAllCommercialServicesResponseModel> commercialServicesFilterData = [];

  getAllCommercialServices(int catId) async {
    isLoading.value = true;
    ResponseItem result;
    result = await CommercialServicesRepo.getAllComercialServices();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          ///getAllCommercialServicesResponseModel
          getAllCommercialServicesResponseModel = List<GetAllCommercialServicesResponseModel>.from(
              result.data.map((x) => GetAllCommercialServicesResponseModel.fromJson(x)));

          getAllCommercialServicesResponseModel.removeWhere((element) => element.subCategoryId != catId);

          ///  commercialServicesFilterData
          commercialServicesFilterData = List<GetAllCommercialServicesResponseModel>.from(
              result.data.map((x) => GetAllCommercialServicesResponseModel.fromJson(x)));

          commercialServicesFilterData.removeWhere((element) => element.subCategoryId != catId);

          update();
        }
      } else {
        showBottomSnackBar(result.message ?? 'Something went wrong');
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=======>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  setCommercialServicesFilter() async {
    commercialServicesFilterData = [];
    for (var element in getAllCommercialServicesResponseModel) {
      if ((element.title.toString().toLowerCase().contains(searchController.text.toString())) &&

          ///State
          (productScreenController.stateSelect.isEmpty ||
              productScreenController.stateSelect == element.state.toString()) &&

          ///City
          (productScreenController.citySelect.isEmpty ||
              productScreenController.citySelect == element.city) &&

          ///NearBy
          (productScreenController.nearBySelect.isEmpty ||
              productScreenController.nearBySelect == element.nearBy) &&

          ///Price-------------------------------------
          (element.price!.toDouble() >= productScreenController.start &&
              productScreenController.end >= element.price!.toDouble())) {
        commercialServicesFilterData.add(element);
      }
    }
    update();
  }

  resetFilter() {
    commercialServicesFilterData = getAllCommercialServicesResponseModel;
    Get.back();
    update();
  }
}
