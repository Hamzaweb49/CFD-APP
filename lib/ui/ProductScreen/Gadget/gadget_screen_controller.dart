import 'dart:developer';
import 'package:claxified_app/api/repo/home_screen_repo.dart';

import 'package:claxified_app/model/get_mobile_brand_response_model.dart';
import 'package:claxified_app/model/get_tablet_brand_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_gadget_response_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetGadgetController extends GetxController {
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());
  RxBool isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();
  int? selectedBrandID;
  String brandSelect = '';
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

  ///GET MOBILE DATA
  List<GetMobileBrandResponseModel>? getMobileBrandResponseModel;
  List<String> mobileList = [];

  getMobileData() async {
    mobileList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetMobileBrandData.getMobileBrandData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getMobileBrandResponseModel = List<GetMobileBrandResponseModel>.from(
              result.data.map((x) => GetMobileBrandResponseModel.fromJson(x)));

          getMobileBrandResponseModel?.forEach((element) {
            mobileList.add(element.brandName.toString());
          });
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=====mobileList==>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET TABLET DATA
  List<GetTabletBrandResponseModel>? getTabletBrandResponseModel;
  List<String> tabletList = [];

  getTabletData() async {
    tabletList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetTabletBrandData.getTabletBrandData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getTabletBrandResponseModel = List<GetTabletBrandResponseModel>.from(
              result.data.map((x) => GetTabletBrandResponseModel.fromJson(x)));

          getTabletBrandResponseModel?.forEach((element) {
            tabletList.add(element.brandName.toString());
          });
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR====tabletList===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  /// GET ALL GADGET DATA
  List<GetAllGadgetResponseModel> filterGadgetData = [];
  List<GetAllGadgetResponseModel> getGadgetDataResponseModel = [];

  getAllGadgetData(int catId) async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetAllGadgetData.getAllGadgetData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          for (var i = 0; i <= result.data.length; i++) {
            if (result.data[i]['isVerified'] == true) {
              if (result.data[i]['subCategoryId'] == catId) {
                /// Gadgets Data
                getGadgetDataResponseModel
                    .add(GetAllGadgetResponseModel.fromJson(result.data[i]));

                /// Filter Data
                filterGadgetData
                    .add(GetAllGadgetResponseModel.fromJson(result.data[i]));
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

  getBrandId({required String? category, required String selectedBrand}) {
    if (category == 'Mobiles') {
      getMobileBrandResponseModel?.forEach((element) {
        if (element.brandName == selectedBrand) {
          selectedBrandID = element.id;
        }
      });
    } else {
      getTabletBrandResponseModel?.forEach((element) {
        if (element.brandName == selectedBrand) {
          selectedBrandID = element.id;
        }
      });
    }

    log('selectedBrandID---------->>>>>> $selectedBrandID');

    update();
  }

  setGadgetsFilter() async {
    filterGadgetData = [];
    for (var element in getGadgetDataResponseModel) {
      if ((element.title
              .toString()
              .toLowerCase()
              .contains(searchController.text.toString())) &&
          (productScreenController.stateSelect.isEmpty ||
              productScreenController.stateSelect ==
                  element.state.toString()) &&
          (productScreenController.citySelect.isEmpty ||
              productScreenController.citySelect == element.city) &&
          (productScreenController.nearBySelect.isEmpty ||
              productScreenController.nearBySelect == element.nearBy) &&
          (selectedBrandID == null ||
              selectedBrandID.toString() == element.mobileBrandId.toString()) &&
          (element.price!.toDouble() >= productScreenController.start &&
              productScreenController.end >= element.price!.toDouble())) {
        filterGadgetData.add(element);
      }
    }
    update();
  }

  resetFilter() {
    filterGadgetData = getGadgetDataResponseModel;
    Get.back();
    update();
  }

  clearData() {
    selectedBrandID = null;
    brandSelect = '';
    searchController.clear();
    update();
  }
}
