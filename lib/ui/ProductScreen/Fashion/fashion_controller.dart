import 'dart:developer';
import 'package:claxified_app/api/repo/fashion_repo.dart';
import 'package:claxified_app/model/product_list_model/get_fashion_data_res_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FashionController extends GetxController {
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());

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

  /// GET FASHION
  List<GetAllFashionDataResponseModel> getAllFashionDataResponseModel = [];
  List<GetAllFashionDataResponseModel> fashionFilterData = [];

  getFashionData(int catId) async {
    isLoading.value = true;
    ResponseItem result;
    result = await FashionRepo.getAllFashionRepo();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          for (var i = 0; i <= result.data.length; i++) {
            if (result.data[i]['isVerified'] == true) {
              if (result.data[i]['subCategoryId'] == catId) {
                /// getAllFashionDataResponseModel Data
                getAllFashionDataResponseModel.add(
                    GetAllFashionDataResponseModel.fromJson(result.data[i]));

                /// Filter Data
                fashionFilterData.add(
                    GetAllFashionDataResponseModel.fromJson(result.data[i]));
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

  setFashionFilter() async {
    fashionFilterData = [];
    for (var element in getAllFashionDataResponseModel) {
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
        fashionFilterData.add(element);
      }
    }
    update();
  }

  resetFilter() {
    fashionFilterData = getAllFashionDataResponseModel;
    Get.back();
    update();
  }
}
