import 'dart:developer';
import 'package:claxified_app/api/repo/jobs_form_repo.dart';
import 'package:claxified_app/model/product_list_model/get_jobs_response_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetJobsController extends GetxController {
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());
  RxBool isLoading = false.obs;
  final TextEditingController searchController = TextEditingController();

  String salaryPeriod = '';
  List<String> salaryPeriodList = ["Hourly", "Monthly", "Weekly", "Yearly"];
  String positionType = '';
  List<String> positionTypeList = [
    'Contract',
    'FullTime',
    'PartTime',
    'Temporary'
  ];
  int? salaryPeriodId;

  getSalaryPeriodID(String salaryPeriodList) {
    if (salaryPeriodList == 'Hourly') {
      salaryPeriodId = 0;
    } else if (salaryPeriodList == 'Monthly') {
      salaryPeriodId = 1;
    } else if (salaryPeriodList == 'Weekly') {
      salaryPeriodId = 2;
    } else if (salaryPeriodList == 'Yearly') {
      salaryPeriodId = 3;
    }
    update();
  }

  int? positionTypeId;

  getPositionTypeID(String positionTypeList) {
    if (positionTypeList == 'Contract') {
      positionTypeId = 0;
    } else if (positionTypeList == 'FullTime') {
      positionTypeId = 1;
    } else if (positionTypeList == 'PartTime') {
      positionTypeId = 2;
    } else if (positionTypeList == 'Temporary') {
      positionTypeId = 3;
    }
    update();
  }

  int selectProductDetails = 0;

  void updateData(int index) {
    selectProductDetails = index;
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

  bool likeSelect = false;

  void selectLikeData() {
    likeSelect = !likeSelect;
    update();
  }

  /// GET ALL GADGET DATA
  List<GetJobsResponseModel> getJobsResponseModel = [];
  List<GetJobsResponseModel> jobsFilterData = [];

  getAllJobsData(int catId) async {
    isLoading.value = true;
    ResponseItem result;
    result = await GetAllJobsData.getAllJobsData();
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          for (var i = 0; i <= result.data.length; i++) {
            if (result.data[i]['isVerified'] == true) {
              if (result.data[i]['subCategoryId'] == catId) {
                /// getJobsResponseModel Data
                getJobsResponseModel
                    .add(GetJobsResponseModel.fromJson(result.data[i]));

                /// Filter Data
                jobsFilterData
                    .add(GetJobsResponseModel.fromJson(result.data[i]));
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

  setJobFilter() async {
    jobsFilterData = [];
    for (var element in getJobsResponseModel) {
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

          /// salaryPeriod ------------------------
          (salaryPeriodId == null ||
              salaryPeriodId.toString() ==
                  element.salaryPeriodType.toString()) &&

          /// positionType ------------------------
          (positionTypeId == null ||
              positionTypeId.toString() == element.positionType.toString())) {
        jobsFilterData.add(element);
      }
    }
    update();
  }

  resetFilter() {
    jobsFilterData = getJobsResponseModel;
    Get.back();
    update();
  }

  clearController() {
    salaryPeriod = "";
    positionType = "";
    salaryPeriodId = null;
    positionTypeId = null;
    searchController.clear();
    update();
  }
}
