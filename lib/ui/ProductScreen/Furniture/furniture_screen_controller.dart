import 'dart:developer';
import 'package:claxified_app/api/repo/furniture_form_repo.dart';
import 'package:claxified_app/model/product_list_model/get_furniture_response_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetFurnitureController extends GetxController {
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());
  RxBool isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();

  int selectProductDetails = 0;

  void updateData(int index) {
    selectProductDetails = index;
    update();
  }

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

  /// GET ALL GADGET DATA
  List<GetFurnitureResponseModel> getFurnitureResponseModel = [];
  List<GetFurnitureResponseModel> filterFurnitureData = [];

  getAllFurnitureData(int catId) async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetAllFurnitureData.getAllFurnitureData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          for (var i = 0; i <= result.data.length; i++) {
            if (result.data[i]['isVerified'] == true) {
              if (result.data[i]['subCategoryId'] == catId) {
                /// getFurnitureResponseModel Data
                getFurnitureResponseModel
                    .add(GetFurnitureResponseModel.fromJson(result.data[i]));

                /// Filter Data
                filterFurnitureData
                    .add(GetFurnitureResponseModel.fromJson(result.data[i]));
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

  setFurnitureFilter() async {
    filterFurnitureData = [];
    for (var element in getFurnitureResponseModel) {
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

          ///price
          (element.price!.toDouble() >= productScreenController.start &&
              productScreenController.end >= element.price!.toDouble())) {
        filterFurnitureData.add(element);
      }
    }
    update();
  }

  resetFilter() {
    filterFurnitureData = getFurnitureResponseModel;
    Get.back();
    update();
  }

  clearData() {
    searchController.clear();
  }
}
