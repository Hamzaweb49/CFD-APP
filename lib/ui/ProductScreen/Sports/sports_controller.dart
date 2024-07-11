import 'dart:developer';

import 'package:claxified_app/api/repo/sports_repo.dart';
import 'package:claxified_app/model/product_list_model/get_sports_data_res_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SportsController extends GetxController {
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());
  RxBool isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();
  bool likeSelect = false;

  void selectLikeData() {
    likeSelect = !likeSelect;
    update();
  }

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

  int selectProductDetails = 0;

  void updateData(int index) {
    selectProductDetails = index;
    update();
  }

  /// GET SPORTS
  List<GetAllSportsDataResponseModel> getAllSportsDataResponseModel = [];
  List<GetAllSportsDataResponseModel> sportsFilterData = [];

  getSportsData(int catId) async {
    isLoading.value = true;
    ResponseItem result;
    result = await SportsRepo.getAllSportsRepo();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          for (var i = 0; i <= result.data.length; i++) {
            if (result.data[i]['isVerified'] == true) {
              if (result.data[i]['subCategoryId'] == catId) {
                /// getAllSportsDataResponseModel Data
                getAllSportsDataResponseModel.add(
                    GetAllSportsDataResponseModel.fromJson(result.data[i]));

                /// Filter Data
                sportsFilterData.add(
                    GetAllSportsDataResponseModel.fromJson(result.data[i]));
              }
            }
          }
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

  setSportFilter() async {
    sportsFilterData = [];
    for (var element in getAllSportsDataResponseModel) {
      if ((element.title
              .toString()
              .toLowerCase()
              .contains(searchController.text.toString())) &&

          ///State
          (productScreenController.stateSelect.isEmpty ||
              productScreenController.stateSelect ==
                  element.state.toString()) &&

          ///City
          (productScreenController.citySelect.isEmpty ||
              productScreenController.citySelect == element.city) &&

          ///NearBy
          (productScreenController.nearBySelect.isEmpty ||
              productScreenController.nearBySelect == element.nearBy) &&

          ///Price-------------------------------------
          (element.price!.toDouble() >= productScreenController.start &&
              productScreenController.end >= element.price!.toDouble())) {
        sportsFilterData.add(element);
      }
    }
    update();
  }

  resetFilter() {
    sportsFilterData = getAllSportsDataResponseModel;
    Get.back();
    update();
  }
}
