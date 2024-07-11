import 'dart:developer';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/api/repo/property_form_repo.dart';
import 'package:claxified_app/model/product_list_model/get_property_response_model.dart';

class GetPropertiesController extends GetxController {
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());
  RxBool isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();

  String bedRoomSelect = '';
  List<String> bedRoomsList = ['1', '2', '3', '4'];

  String bathRoomSelect = '';
  List<String> bathRoomsList = ['1', '2', '3', '4'];

  String houseTypeSelect = '';
  int? houseTypeId;
  List<String> houseTypeList = [
    'Apartment',
    'BuilderFloor',
    'FarmHouses',
    'HousesVilas',
  ];

  getHouseID(String houseType) {
    if (houseType == 'Apartment') {
      houseTypeId = 0;
    } else if (houseType == 'BuilderFloor') {
      houseTypeId = 1;
    } else if (houseType == 'FarmHouses') {
      houseTypeId = 2;
    } else if (houseType == 'HousesVilas') {
      houseTypeId = 3;
    }
    update();
  }

  String furnishingTypeSelect = '';
  int? furnishingTypeId;
  List<String> furnishingTypeList = [
    'Furnished',
    'SemiFurnished',
    'UnFurnished',
  ];

  getFurnishingID(String furnishingType) {
    if (furnishingType == 'Furnished') {
      furnishingTypeId = 0;
    } else if (furnishingType == 'SemiFurnished') {
      furnishingTypeId = 1;
    } else if (furnishingType == 'UnFurnished') {
      furnishingTypeId = 2;
    }
    update();
  }

  String constructionStatusTypeSelect = '';
  int? constructionStatusTypeId;
  List<String> constructionStatusList = [
    'NewLaunch',
    'ReadyToMove',
    'UnderConstruction',
  ];

  getConstructionStatusTypeID(String constructionStatusType) {
    if (constructionStatusType == 'NewLaunch') {
      constructionStatusTypeId = 0;
    } else if (constructionStatusType == 'ReadyToMove') {
      constructionStatusTypeId = 1;
    } else if (constructionStatusType == 'UnderConstruction') {
      constructionStatusTypeId = 2;
    }
    update();
  }

  String listedByTypeSelect = '';
  int? listedById;
  List<String> listedByList = [
    'Builder',
    'Dealer',
    'Owner',
  ];

  getListedByID(String listredBy) {
    if (listredBy == 'Builder') {
      listedById = 0;
    } else if (listredBy == 'Dealer') {
      listedById = 1;
    } else if (listredBy == 'Owner') {
      listedById = 2;
    }
    update();
  }

  String bachelorsAllowedSelect = '';
  int? bachelorsAllowedId;
  List<String> bachelorsAllowedList = ['No', 'Yes'];

  getBachelorsAllowedID(String bachelorsAllowed) {
    if (bachelorsAllowed == 'No') {
      bachelorsAllowedId = 0;
    } else if (bachelorsAllowed == 'Yes') {
      bachelorsAllowedId = 1;
    }
    update();
  }

  double startSBA = 1.00;
  double endSBA = 1000000.00;
  double startPA = 1.00;
  double endPA = 1000000.00;

  String serviceTypeSelect = '';
  int? serviceTypeId;
  List<String> serviceTypeList = [
    'ForSale',
    'ForRent',
    'ForLease',
  ];

  getServiceTypeID(String serviceType) {
    if (serviceType == 'ForSale') {
      serviceTypeId = 0;
    } else if (serviceType == 'ForRent') {
      serviceTypeId = 1;
    } else if (serviceType == 'ForLease') {
      serviceTypeId = 2;
    }
    update();
  }

  String subTypeSelect = '';
  int? subTypeId;
  List<String> subTypeList = [
    'GuestHouse',
    'PG',
    'Roomate',
  ];

  getSubTypeID(String subType) {
    if (subType == 'GuestHouse') {
      subTypeId = 0;
    } else if (subType == 'PG') {
      subTypeId = 1;
    } else if (subType == 'Roomate') {
      subTypeId = 2;
    }
    update();
  }

  /// GET ALL PROPERTY DATA

  List<GetAllPropertyResponseModel> getAllPropertyResponseModel = [];
  List<GetAllPropertyResponseModel> propertyFilterData = [];

  getAllPropertyData(int catId) async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetAllPropertyData.getAllPropertyData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;

          for (var i = 0; i <= result.data.length; i++) {
            if (result.data[i]['isVerified'] == true) {
              if (result.data[i]['subCategoryId'] == catId) {
                /// getAllPropertyResponseModel Data
                getAllPropertyResponseModel
                    .add(GetAllPropertyResponseModel.fromJson(result.data[i]));

                /// Filter Data
                propertyFilterData
                    .add(GetAllPropertyResponseModel.fromJson(result.data[i]));
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

  List<int> likedData = [];

  addFavouriteData(int index) {
    if (likedData.contains(index)) {
      likedData.remove(index);
    } else {
      likedData.add(index);
    }
    update();
  }

  setPropertiesFilter() async {
    propertyFilterData = [];
    for (var element in getAllPropertyResponseModel) {
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

          ///Price
          (element.price!.toDouble() >= productScreenController.start &&
              productScreenController.end >= element.price!.toDouble()) &&

          /// Super BuildUp Area
          (element.superBuildUpArea!.toDouble() == 0.0 ||
              element.superBuildUpArea!.toDouble() >= startSBA &&
                  endSBA >= element.superBuildUpArea!.toDouble()) &&

          /// Plot Area
          (element.plotArea!.toDouble() == 0.0 ||
              element.plotArea!.toDouble() >= startPA &&
                  endPA >= element.plotArea!.toDouble()) &&

          /// Bed Room
          (bedRoomSelect.isEmpty ||
              bedRoomSelect.toString() == element.bedrooms.toString()) &&

          /// Bath Room
          (bathRoomSelect.isEmpty ||
              bathRoomSelect.toString() == element.bathrooms.toString()) &&

          /// House Type
          (houseTypeId == null ||
              houseTypeId.toString() == element.houseType.toString()) &&

          /// Furnishing Type
          (furnishingTypeId == null ||
              furnishingTypeId.toString() ==
                  element.furnishingStatus.toString()) &&

          /// Construction Type
          (constructionStatusTypeId == null ||
              constructionStatusTypeId.toString() ==
                  element.constructionStatus.toString()) &&

          /// Listed By
          (listedById == null ||
              listedById.toString() == element.listedBy.toString()) &&

          /// Bachelors Allowed
          (bachelorsAllowedId == null ||
              bachelorsAllowedId.toString() ==
                  element.bachelorAllowed.toString()) &&

          /// Service Type
          (serviceTypeId == null ||
              serviceTypeId.toString() == element.serviceType.toString()) &&

          /// Sub Type
          (subTypeId == null ||
              subTypeId.toString() == element.pgType.toString())) {
        propertyFilterData.add(element);
      }
    }
    update();
  }

  resetFilter() {
    propertyFilterData = getAllPropertyResponseModel;
    Get.back();
    update();
  }

  clearData() {
    bedRoomSelect = '';
    bathRoomSelect = '';
    houseTypeSelect = '';
    houseTypeId = null;
    furnishingTypeSelect = '';
    furnishingTypeId = null;
    constructionStatusTypeSelect = '';
    constructionStatusTypeId = null;
    listedByTypeSelect = '';
    listedById = null;
    bachelorsAllowedSelect = '';
    bachelorsAllowedId = null;
    serviceTypeSelect = '';
    serviceTypeId = null;
    subTypeSelect = '';
    subTypeId = null;
    startSBA = 1.00;
    endSBA = 1000000.00;
    endPA = 1000000.00;
    startPA = 1.00;
  }
}
