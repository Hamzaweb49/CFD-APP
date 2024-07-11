import 'dart:developer';

import 'package:claxified_app/api/repo/vehicle_form_repo.dart';
import 'package:claxified_app/model/get_bicycle_brand_response_model.dart';
import 'package:claxified_app/model/get_bike_brand_response_model.dart';
import 'package:claxified_app/model/get_bike_model_response_model.dart';
import 'package:claxified_app/model/get_car_brand_response_model.dart';
import 'package:claxified_app/model/get_car_model_response_model.dart';
import 'package:claxified_app/model/get_scooty_brand_response_model.dart';
import 'package:claxified_app/model/product_list_model/get_vehicle_response_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetVehicleController extends GetxController {
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());
  RxBool isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();
  int? selectedBrandID;
  String brandSelect = '';
  double kmStart = 1.00;
  double kmEnd = 100000.00;

  List<String> noOfOwner = ['1', '2', '3', '4'];
  List<String> fuelType = ['Petrol', 'Diesel', 'CNG', 'Electric'];
  List<String> transmissionType = ['Manual', 'Automatic'];
  List<String> filteredTransmissionList = [];
  List<String> filteredFuelTypeList = [];
  String selectOwnerCount = '';
  String selectFuelType = '';
  int? selectFuelTypeId;
  String selectTransmissionType = '';
  int? selectTransmissionTypeId;
  TextEditingController yearsFromController = TextEditingController();
  TextEditingController yearsToController = TextEditingController();
  int selectProductDetails = 0;

  void filterFuelTypes(String? subCategoryName) {
    if (subCategoryName == "Bikes" || subCategoryName == "Scooty") {
      filteredFuelTypeList = ["Petrol", "Electric"];
    } else {
      filteredFuelTypeList = fuelType;
    }
    update();
  }

  void filterTransmissionTypes(String? subCategoryName) {
    // print("Subcategory name: $subCategoryName");
    if (subCategoryName == "Bikes" || subCategoryName == "Scooty") {
      filteredTransmissionList = ["Manual"];
    } else {
      filteredTransmissionList = transmissionType;
    }
    update();
  }

  void updateData(int index) {
    selectProductDetails = index;
    update();
  }

  bool likeSelect = false;

  void selectLikeData() {
    likeSelect = !likeSelect;
    update();
  }

  Future getBrandId({required String value, required String category}) async {
    if (category == 'Cars') {
      for (var element in getCarBrandResponseModel) {
        if (element.brandName == value) {
          selectedBrandID = element.id;
          break;
        }
      }
    } else if (category == 'Bikes') {
      for (var element in getBikeBrandResponseModel) {
        if (element.brandName == value) {
          selectedBrandID = element.id;
          break;
        }
      }
    } else if (category == 'Scooty') {
      for (var element in getScootyBrandResponseModel) {
        if (element.brandName == value) {
          selectedBrandID = element.id;
          break;
        }
      }
    } else {
      for (var element in getBicycleBrandResponseModel) {
        if (element.brandName == value) {
          selectedBrandID = element.id;
          break;
        }
      }
    }
    log('carBrandId---------->>>>>> $selectedBrandID');
    update();
  }

  getFuelID(String fuelType) {
    if (fuelType == 'Petrol') {
      selectFuelTypeId = 0;
    } else if (fuelType == 'Diesel') {
      selectFuelTypeId = 1;
    } else if (fuelType == 'LPG') {
      selectFuelTypeId = 2;
    } else if (fuelType == 'Electric') {
      selectFuelTypeId = 3;
    }
    update();
  }

  getTransmissionID(String transmissionType) {
    if (transmissionType == 'Manual') {
      selectTransmissionTypeId = 0;
    } else {
      selectTransmissionTypeId = 1;
    }
    update();
  }

  /// GET ALL VEHICLES DATA

  List<GetAllVehicleResponseModel> getAllVehicleResponseModel = [];
  List<GetAllVehicleResponseModel> vehicleFilterData = [];

  getAllVehicleData(int catId) async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetAllVehicleData.getAllVehicleData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          for (var i = 0; i <= result.data.length; i++) {
            if (result.data[i]['isVerified'] == true) {
              if (result.data[i]['subCategoryId'] == catId) {
                /// getAllVehicleResponseModel Data
                getAllVehicleResponseModel
                    .add(GetAllVehicleResponseModel.fromJson(result.data[i]));

                /// Filter Data
                vehicleFilterData
                    .add(GetAllVehicleResponseModel.fromJson(result.data[i]));
              }
            }
          }

          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR===AllVehicleData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET CAR BRAND DATA
  List<GetCarBrandResponseModel> getCarBrandResponseModel = [];
  List<String> carBrandList = [];

  getCarBrandsData() async {
    //getCarBrandResponseModel?.clear();
    carBrandList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetCarBrandData.getCarBrandData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          getCarBrandResponseModel = List<GetCarBrandResponseModel>.from(
              result.data.map((x) => GetCarBrandResponseModel.fromJson(x)));

          for (var element in getCarBrandResponseModel) {
            carBrandList.add(element.brandName.toString());
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR===GetMobileData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET CAR MODEL DATA
  List<GetCarModelResponseModel> getCarModelResponseModel = [];
  List<String> carModelList = [];

  getCarModelData(String id) async {
    // getCarModelResponseModel.clear();
    carModelList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetCarModelData.getCarModelData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          getCarModelResponseModel = List<GetCarModelResponseModel>.from(
              result.data.map((x) => GetCarModelResponseModel.fromJson(x)));

          log('getCarModelResponseModel---------->>>>>> $getCarModelResponseModel');

          for (var element in getCarModelResponseModel) {
            carModelList.add(element.model.toString());

            log('element.model---------->>>>>> ${element.model}');
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

  ///GET BIKE BRAND DATA

  List<GetBikeBrandResponseModel> getBikeBrandResponseModel = [];
  List<String> bikeBrandList = [];

  getBikeBrandsData() async {
    bikeBrandList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetBikeBrandData.getBikeBrandData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          getBikeBrandResponseModel = List<GetBikeBrandResponseModel>.from(
              result.data.map((x) => GetBikeBrandResponseModel.fromJson(x)));

          for (var element in getBikeBrandResponseModel) {
            bikeBrandList.add(element.brandName.toString());
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR===GetMobileData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET Bike MODEL DATA
  List<GetBikeModelResponseModel> getBikeModelResponseModel = [];
  List<String> bikeModelList = [];

  getBikeModelData(String id) async {
    // getCarModelResponseModel.clear();
    bikeModelList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetBikeModelData.getBikeModelData(id);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          getBikeModelResponseModel = List<GetBikeModelResponseModel>.from(
              result.data.map((x) => GetBikeModelResponseModel.fromJson(x)));

          log('getBikeModelResponseModel---------->>>>>> ${getBikeModelResponseModel}');

          for (var element in getBikeModelResponseModel) {
            bikeModelList.add(element.model.toString());
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

  ///GET SCOOTY BRAND DATA

  List<GetScootyBrandResponseModel> getScootyBrandResponseModel = [];
  List<String> scootyBrandList = [];

  getScootyBrandsData() async {
    scootyBrandList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetScootyBrandData.getScootyBrandData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          getScootyBrandResponseModel = List<GetScootyBrandResponseModel>.from(
              result.data.map((x) => GetScootyBrandResponseModel.fromJson(x)));

          for (var element in getScootyBrandResponseModel) {
            scootyBrandList.add(element.brandName.toString());

            log("----SCOOTY-BRAND-NAME-${element.brandName}");
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR===ScootyBrands==>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }

  ///GET Bicycle BRAND DATA

  List<GetBicycleBrandResponseModel> getBicycleBrandResponseModel = [];
  List<String> bicycleBrandList = [];

  getBicycleBrandsData() async {
    bicycleBrandList = [];
    isLoading.value = true;
    ResponseItem result;
    result = await GetBicycleBrandData.getBicycleBrandData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          getBicycleBrandResponseModel =
              List<GetBicycleBrandResponseModel>.from(result.data
                  .map((x) => GetBicycleBrandResponseModel.fromJson(x)));

          for (var element in getBicycleBrandResponseModel) {
            bicycleBrandList.add(element.brandName.toString());
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      log('ERROR===GetMobileData===>>>>====>>>>$e');
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

  setVehiclesFilter() async {
    vehicleFilterData = [];
    for (var element in getAllVehicleResponseModel) {
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

          ///Brand
          (selectedBrandID == null ||
              selectedBrandID.toString() ==
                  element.vehicelBrandId.toString()) &&

          ///Price
          (element.price!.toDouble() >= productScreenController.start &&
              productScreenController.end >= element.price!.toDouble()) &&

          ///date
          (yearsFromController.text.isEmpty ||
              int.parse(element.createdOn!.split('-').first) >=
                  int.parse(yearsFromController.text)) &&
          (yearsToController.text.isEmpty ||
              int.parse(yearsToController.text) >=
                  int.parse(element.createdOn!.split('-').first)) &&

          ///KM driven
          (element.kmDriven!.toDouble() >= kmStart &&
              kmEnd >= element.kmDriven!.toDouble()) &&

          ///Owner Count
          (selectOwnerCount.isEmpty ||
              selectOwnerCount.toString() == element.noOfOwner.toString()) &&

          ///Fuel
          (selectFuelTypeId == null ||
              selectFuelTypeId.toString() == element.fuelType.toString()) &&

          ///Transmission
          (selectTransmissionTypeId == null ||
              selectTransmissionTypeId.toString() ==
                  element.transmissionType.toString())) {
        vehicleFilterData.add(element);
      }
    }
    update();
  }

  resetFilter() {
    vehicleFilterData = getAllVehicleResponseModel;
    Get.back();
    update();
  }

  clearController() {
    selectedBrandID = null;
    selectOwnerCount = '';
    selectFuelType = '';
    selectFuelTypeId = null;
    selectTransmissionType = '';
    selectTransmissionTypeId = null;
    kmStart = 1.00;
    kmEnd = 100000.00;
    yearsFromController.clear();
    yearsToController.clear();
    brandSelect = '';
    update();
  }
}
