// import 'dart:convert';
// import 'package:claxified_app/api/repo/auth_screen_repo.dart';
// import 'package:claxified_app/api/repo/home_screen_repo.dart';
// import 'package:claxified_app/model/get_all_category_response_model.dart';
// import 'package:claxified_app/model/get_dashboard_data_response_model.dart';
// import 'package:claxified_app/model/post_otp_login_response_model.dart';
// import 'package:claxified_app/model/response_item.dart';
// import 'package:claxified_app/theme/app_layout.dart';
// import 'package:claxified_app/utils/app_routes.dart';
// import 'package:claxified_app/utils/shared_prefs.dart';
// import 'package:get/get.dart';
//
// class HomeScreenController extends GetxController {
//bool userMobile = false;
// List<int> likedData = [];

// addFavouriteData(int index) {
//   if (likedData.contains(index)) {
//     likedData.remove(index);
//   } else {
//     likedData.add(index);
//   }
//   update();
// }

// RxBool isLoading = false.obs;
//  RxBool dashboardLoading = false.obs;
//List<GetAllCategoryResponseModel>? getAllCategoryResponseModel;

// getAllCategoryScreen() async {
//   dashboardLoading.value = true;
//   ResponseItem result;
//   result = await GetAllCategoryRepo.getAllCategoryRepo();
//   try {
//     if (result.status) {
//       if (result.data != null) {
//         getAllCategoryResponseModel = List<GetAllCategoryResponseModel>.from(
//             result.data.map((x) => GetAllCategoryResponseModel.fromJson(x)));
//         dashboardLoading.value = false;
//         update();
//       }
//     } else {
//       showBottomSnackBar(result.message!);
//       dashboardLoading.value = false;
//     }
//   } catch (e) {
//     dashboardLoading.value = false;
//   }
//   update();
// }

///---------------
//
// List<GetAllDashboardDataResponseModel> getAllDashboardDataResponseModel = [];
//
// getAllDashboardDataController() async {
//   dashboardLoading.value = true;
//   ResponseItem result;
//   result = await GetAllDashBoardData.getAllDashBoardData();
//   try {
//     if (result.status) {
//       if (result.data != null) {
//         getAllDashboardDataResponseModel =
//             List<GetAllDashboardDataResponseModel>.from(result.data
//                 .map((x) => GetAllDashboardDataResponseModel.fromJson(x)));
//
//         dashboardLoading.value = false;
//         for (var element in getAllDashboardDataResponseModel) {
//           if (element.gadgetImageList!.isNotEmpty ||
//               element.gadgetImageList == null) {
//             element.productImage = element.gadgetImageList;
//           }
//           if (element.vehicleImageList!.isNotEmpty ||
//               element.vehicleImageList == null) {
//             element.productImage = element.vehicleImageList;
//           }
//           if (element.propertyImageList!.isNotEmpty ||
//               element.propertyImageList == null) {
//             element.productImage = element.propertyImageList;
//           }
//           if (element.jobImageList!.isNotEmpty ||
//               element.jobImageList == null) {
//             element.productImage = element.jobImageList;
//           }
//           if (element.electronicApplianceImageList!.isNotEmpty ||
//               element.electronicApplianceImageList == null) {
//             element.productImage = element.electronicApplianceImageList;
//           }
//           if (element.furnitureImageList!.isNotEmpty ||
//               element.furnitureImageList == null) {
//             element.productImage = element.furnitureImageList;
//           }
//           if (element.bookImageList!.isNotEmpty ||
//               element.bookImageList == null) {
//             element.productImage = element.bookImageList;
//           }
//           if (element.sportImageList!.isNotEmpty ||
//               element.sportImageList == null) {
//             element.productImage = element.sportImageList;
//           }
//           if (element.petImageList!.isNotEmpty ||
//               element.petImageList == null) {
//             element.productImage = element.petImageList;
//           }
//           if (element.fashionImageList!.isNotEmpty ||
//               element.fashionImageList == null) {
//             element.productImage = element.fashionImageList;
//           }
//           if (element.commercialServiceImageList!.isNotEmpty ||
//               element.commercialServiceImageList == null) {
//             element.productImage = element.commercialServiceImageList;
//           }
//         }
//         update();
//       }
//     } else {
//       showBottomSnackBar(result.message!);
//       dashboardLoading.value = false;
//     }
//   } catch (e) {
//     dashboardLoading.value = false;
//   }
//   update();
// }

/// Auth send otp controller

// postSendOtp({required Map<String, dynamic> sendOtp}) async {
//   isLoading.value = true;
//   ResponseItem result;
//   result = await AuthSendOtp.authSendOtpRepo(sendOtp);
//   try {
//     if (result.status) {
//       if (result.data != null) {
//         isLoading.value = false;
//         userMobile = true;
//         update();
//       }
//     } else {
//       showBottomSnackBar(result.message!);
//       isLoading.value = false;
//     }
//   } catch (e) {
//     isLoading.value = false;
//   }
//   update();
// }

//   ///Otp Login  controller
//   UserLoginOtpResponseModel? postLoginOtpResponseModel;
//
//   postLoginOtp(
//       {required String mobileNo,
//       required String otp,
//       required String name}) async {
//     isLoading.value = true;
//     ResponseItem result;
//     result = await AuthOtpLogin.authOtpLoginRepo(
//         name: name, mobileNo: mobileNo, otp: otp);
//     try {
//       if (result.status) {
//         if (result.data != null) {
//           postLoginOtpResponseModel =
//               UserLoginOtpResponseModel.fromJson(result.data);
//
//           preferences.putString(
//               SharedPreference.userData, jsonEncode(result.data));
//
//           preferences.putBool(SharedPreference.isLogin, true);
//
//           Get.toNamed(Routes.selectCategoryScreenGrid);
//           showSuccessSnackBar('Login Successfully');
//
//           //  isLoading.value = false;
//         }
//       } else {
//         showSuccessSnackBar('Please Enter Valid Otp');
//         // showBottomSnackBar(result.message!);
//         isLoading.value = false;
//       }
//     } catch (e) {
//       isLoading.value = false;
//     }
//     update();
//   }
// }
