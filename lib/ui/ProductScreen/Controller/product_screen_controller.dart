import 'dart:developer';
import 'package:claxified_app/api/repo/home_screen_repo.dart';
import 'package:claxified_app/model/get_city_response_model.dart';
import 'package:claxified_app/model/get_nearby_response_model.dart';
import 'package:claxified_app/model/get_state_response_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/model/sub_category_response_model.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductScreenController extends GetxController {
  ///productDetailscreen
  int selectProductDetails = 0;
  String stateIdSelect = '0';
  String cityIdSelect = '0';
  String stateSelect = '';
  String citySelect = '';

  double start = 1.00;
  double end = 1000000.00;

  TextEditingController nearByController = TextEditingController();

  String nearBySelect = '';

  void updateData(int index) {
    selectProductDetails = index;
    update();
  }

  bool likeSelect = false;

  void selectLikeData() {
    likeSelect = !likeSelect;
    update();
  }

  ///seeAllDetailScreen
  int selectSeeAllDetails = 0;

  void selectSeeAllDetailScreen(int index) {
    selectSeeAllDetails = index;
    update();
  }

  ///selectCategoryScreen
  int selectCategory = 0;

  void selectCategoryScreen(int index) {
    selectCategory = index;
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

  ///STATE ID
  Future stateId() async {
    for (var element in getAllStateResponseModel) {
      if (element.name == stateSelect) {
        stateIdSelect = element.id.toString();
      }
    }

    update();
  }

  ///CITY ID
  Future cityId() async {
    for (var element in getAllCityResponseModel) {
      if (element.name == citySelect) {
        cityIdSelect = element.id.toString();
      }
    }
    log('stateIdSelect---------->>>>>> $cityIdSelect');
    update();
  }

  RxBool isLoading = false.obs;
  List<SubCategoryResponseModel>? selectedCategoryResponseModel;

  selectSubCategory(int id) async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetSubCategoryRepo.getSubCategoryRepo(id: id);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          selectedCategoryResponseModel = List<SubCategoryResponseModel>.from(
              result.data.map((x) => SubCategoryResponseModel.fromJson(x)));
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=====selectedCategory==>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET STATE DATA
  List<GetAllStateResponseModel> getAllStateResponseModel = [];
  List<String> stateList = [];

  getStateData() async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetStateData.getStateData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getAllStateResponseModel = List<GetAllStateResponseModel>.from(
              result.data.map((x) => GetAllStateResponseModel.fromJson(x)));

          for (var element in getAllStateResponseModel) {
            stateList.add(element.name.toString() ?? "");
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=======>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET CITY DATA
  List<GetAllCityResponseModel> getAllCityResponseModel = [];
  List<String> cityList = [];

  getCityData(String id) async {
    getAllCityResponseModel.clear();
    cityList.clear();

    isLoading.value = true;
    ResponseItem result;
    result = await GetCityData.getCityData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getAllCityResponseModel = List<GetAllCityResponseModel>.from(
              result.data.map((x) => GetAllCityResponseModel.fromJson(x)));
          for (var element in getAllCityResponseModel) {
            cityList.add(element.name.toString() ?? "");
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR=======>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET NEAR BY DATA
  List<GetAllNearByResponseModel> getAllNearByResponseModel = [];
  List<String> nearByList = [];

  getNearByData(String id) async {
    nearByList = [];
    print('-------CALL');
    isLoading.value = true;
    ResponseItem result;
    result = await GetNearByData.getNearByData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getAllNearByResponseModel = List<GetAllNearByResponseModel>.from(
              result.data.map((x) => GetAllNearByResponseModel.fromJson(x)));

          getAllNearByResponseModel.forEach((element) {
            nearByList.add(element.name.toString());
          });
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR====GetNearByData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  clearData() {
    stateSelect = '';
    stateIdSelect = '';
    cityIdSelect = '';
    getAllNearByResponseModel = [];
    getAllCityResponseModel = [];
    nearBySelect = '';
    start = 1.00;
    end = 1000000.00;
    citySelect = '';
  }
}
