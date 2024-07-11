import 'dart:async';
import 'dart:convert';
import 'package:claxified_app/api/repo/auth_screen_repo.dart';
import 'package:claxified_app/api/repo/home_screen_repo.dart';
import 'package:claxified_app/model/get_all_category_response_model.dart';
import 'package:claxified_app/model/get_dashboard_data_response_model.dart';
import 'package:claxified_app/model/post_otp_login_response_model.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/utils/app_routes.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  int selected = 0;
  final formKey = GlobalKey<FormState>();

  changeTabs(int index) {
    selected = index;
    update();
  }

  Timer? timer;
  int start = 30;

  bool userMobile = false;

  List<int> likedData = [];

  addFavouriteData(int index) {
    if (likedData.contains(index)) {
      likedData.remove(index);
    } else {
      likedData.add(index);
    }
    update();
  }

  int? select;

  void updateData(int index) {
    select = index;
    update();
  }

  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool dashboardLoading = false.obs;
  List<GetAllCategoryResponseModel>? getAllCategoryResponseModel;

  getAllCategory() async {
    dashboardLoading.value = true;
    ResponseItem result;
    result = await GetAllCategoryRepo.getAllCategoryRepo();
    try {
      if (result.status) {
        if (result.data != null) {
          getAllCategoryResponseModel = List<GetAllCategoryResponseModel>.from(
              result.data.map((x) => GetAllCategoryResponseModel.fromJson(x)));
          dashboardLoading.value = false;
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        dashboardLoading.value = false;
      }
    } catch (e) {
      dashboardLoading.value = false;
    }
    update();
  }

  ///---------------

  List<GetAllDashboardDataResponseModel> getAllDashboardDataResponseModel = [];

  getAllDashboardDataController() async {
    dashboardLoading.value = true;
    ResponseItem result;
    result = await GetAllDashBoardData.getAllDashBoardData();
    try {
      if (result.status) {
        if (result.data != null) {
          getAllDashboardDataResponseModel =
              List<GetAllDashboardDataResponseModel>.from(result.data
                  .map((x) => GetAllDashboardDataResponseModel.fromJson(x)));

          dashboardLoading.value = false;
          for (var element in getAllDashboardDataResponseModel) {
            if (element.gadgetImageList!.isNotEmpty ||
                element.gadgetImageList == null) {
              element.productImage = element.gadgetImageList;
            }
            if (element.vehicleImageList!.isNotEmpty ||
                element.vehicleImageList == null) {
              element.productImage = element.vehicleImageList;
            }
            if (element.propertyImageList!.isNotEmpty ||
                element.propertyImageList == null) {
              element.productImage = element.propertyImageList;
            }
            if (element.jobImageList!.isNotEmpty ||
                element.jobImageList == null) {
              element.productImage = element.jobImageList;
            }
            if (element.electronicApplianceImageList!.isNotEmpty ||
                element.electronicApplianceImageList == null) {
              element.productImage = element.electronicApplianceImageList;
            }
            if (element.furnitureImageList!.isNotEmpty ||
                element.furnitureImageList == null) {
              element.productImage = element.furnitureImageList;
            }
            if (element.bookImageList!.isNotEmpty ||
                element.bookImageList == null) {
              element.productImage = element.bookImageList;
            }
            if (element.sportImageList!.isNotEmpty ||
                element.sportImageList == null) {
              element.productImage = element.sportImageList;
            }
            if (element.petImageList!.isNotEmpty ||
                element.petImageList == null) {
              element.productImage = element.petImageList;
            }
            if (element.fashionImageList!.isNotEmpty ||
                element.fashionImageList == null) {
              element.productImage = element.fashionImageList;
            }
            if (element.commercialServiceImageList!.isNotEmpty ||
                element.commercialServiceImageList == null) {
              element.productImage = element.commercialServiceImageList;
            }
          }
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        dashboardLoading.value = false;
      }
    } catch (e) {
      dashboardLoading.value = false;
    }
    update();
  }

  // String image = '';
  // String manageAdsImage(int index) {
  //   if (getAllDashboardDataResponseModel[index].categoryId == 1) {
  //     if (getAllDashboardDataResponseModel[index].gadgetImageList.isNotEmpty) {
  //       image = getAllDashboardDataResponseModel[index]
  //               .gadgetImageList?[0]
  //               .imageUrl ??
  //           '';
  //     } else {
  //       image = '';
  //     }
  //   } else if (getAllDashboardDataResponseModel[index].categoryId == 2) {
  //     if (getAllDashboardDataResponseModel[index].vehicleImageList.isNotEmpty) {
  //       image = getAllDashboardDataResponseModel[index]
  //               .vehicleImageList?[0]
  //               .imageUrl ??
  //           '';
  //     } else {
  //       image = '';
  //     }
  //   } else if (getAllDashboardDataResponseModel[index].categoryId == 3) {
  //     if (getAllDashboardDataResponseModel[index]
  //         .propertyImageList
  //         .isNotEmpty) {
  //       image = getAllDashboardDataResponseModel[index]
  //               .propertyImageList?[0]
  //               .imageUrl ??
  //           '';
  //     } else {
  //       image = '';
  //     }
  //   } else if (getAllDashboardDataResponseModel[index].categoryId == 4) {
  //     if (getAllDashboardDataResponseModel[index].jobImageList.isNotEmpty) {
  //       image =
  //           getAllDashboardDataResponseModel[index].jobImageList?[0].imageUrl ??
  //               '';
  //     } else {
  //       image = '';
  //     }
  //   } else if (getAllDashboardDataResponseModel[index].categoryId == 5) {
  //     if (getAllDashboardDataResponseModel[index]
  //         .electronicApplianceImageList
  //         .isNotEmpty) {
  //       image = getAllDashboardDataResponseModel[index]
  //               .electronicApplianceImageList?[0]
  //               .imageUrl ??
  //           '';
  //     } else {
  //       image = '';
  //     }
  //   } else if (getAllDashboardDataResponseModel[index].categoryId == 6) {
  //     if (getAllDashboardDataResponseModel[index]
  //         .furnitureImageList
  //         .isNotEmpty) {
  //       image = getAllDashboardDataResponseModel[index]
  //               .furnitureImageList?[0]
  //               .imageUrl ??
  //           '';
  //     } else {
  //       image = '';
  //     }
  //   } else if (getAllDashboardDataResponseModel[index].categoryId == 7) {
  //     if (getAllDashboardDataResponseModel[index].bookImageList.isNotEmpty) {
  //       image = getAllDashboardDataResponseModel[index]
  //               .bookImageList?[0]
  //               .imageUrl ??
  //           '';
  //     } else {
  //       image = '';
  //     }
  //   } else if (getAllDashboardDataResponseModel[index].categoryId == 8) {
  //     if (getAllDashboardDataResponseModel[index].sportImageList.isNotEmpty) {
  //       image = getAllDashboardDataResponseModel[index]
  //               .sportImageList?[0]
  //               .imageUrl ??
  //           '';
  //     } else {
  //       image = '';
  //     }
  //   } else if (getAllDashboardDataResponseModel[index].categoryId == 9) {
  //     if (getAllDashboardDataResponseModel[index].petImageList.isNotEmpty) {
  //       image =
  //           getAllDashboardDataResponseModel[index].petImageList?[0].imageUrl ??
  //               '';
  //     } else {
  //       image = '';
  //     }
  //   } else if (getAllDashboardDataResponseModel[index].categoryId == 10) {
  //     if (getAllDashboardDataResponseModel[index].fashionImageList.isNotEmpty) {
  //       image = getAllDashboardDataResponseModel[index]
  //               .fashionImageList?[0]
  //               .imageUrl ??
  //           '';
  //     } else {
  //       image = '';
  //     }
  //   } else if (getAllDashboardDataResponseModel[index].categoryId == 11) {
  //     if (getAllDashboardDataResponseModel[index]
  //         .commercialServiceImageList
  //         .isNotEmpty) {
  //       image = getAllDashboardDataResponseModel[index]
  //               .commercialServiceImageList?[0]
  //               .imageUrl ??
  //           '';
  //     } else {
  //       image = '';
  //     }
  //   } else {
  //     image = '';
  //   }
  //   return image;
  // }

  /// Auth send otp controller

  postSendOtp({required Map<String, dynamic> sendOtp}) async {
    isLoading.value = true;
    ResponseItem result;
    result = await AuthSendOtp.authSendOtpRepo(sendOtp);
    try {
      if (result.status) {
        if (result.data != null) {
          isLoading.value = false;
          userMobile = true;
          update();
        }
      } else {
        showBottomSnackBar(result.message!);
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  ///Otp Login  controller
  UserLoginOtpResponseModel? postLoginOtpResponseModel;

  postLoginOtp({
    required String mobileNo,
    required String otp,
    required String name,
    required String isFrom,
  }) async {
    isLoading.value = true;
    ResponseItem result;
    result = await AuthOtpLogin.authOtpLoginRepo(
      name: name,
      mobileNo: mobileNo,
      otp: otp,
    );
    try {
      if (result.status) {
        if (result.data != null) {
          postLoginOtpResponseModel =
              UserLoginOtpResponseModel.fromJson(result.data);

          preferences.putString(
              SharedPreference.userData, jsonEncode(result.data));
          Get.back();
          preferences.putBool(SharedPreference.isLogin, true);

          preferences.putInt(
              SharedPreference.userId, postLoginOtpResponseModel?.id ?? 0);

          if (isFrom == 'Appbar') {
            Get.toNamed(Routes.selectCategoryScreenGrid);
          } else {
            Get.back();
            changeTabs(4);
          }
          showSuccessSnackBar('Login Successfully');

          isLoading.value = false;
        }
      } else {
        showSuccessSnackBar('Please Enter Valid Otp!');
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }
}
