import 'dart:convert';
import 'dart:developer';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/model/post_otp_login_response_model.dart';
import 'package:claxified_app/model/sub_category_response_model.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/ui/FormScreen/Properties/properties_form_controller.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_button.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:claxified_app/widgets/app_drop_down.dart';
import 'package:claxified_app/widgets/app_loading_widget.dart';
import 'package:claxified_app/widgets/app_text_fields.dart';
import 'package:claxified_app/widgets/form_screen_review_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class PropertiesFormScreen extends StatefulWidget {
  const PropertiesFormScreen({super.key});

  @override
  State<PropertiesFormScreen> createState() => _PropertiesFormScreenState();
}

class _PropertiesFormScreenState extends State<PropertiesFormScreen> {
  PropertiesFormScreenController propertiesFormScreenController =
      Get.put(PropertiesFormScreenController());
  UserLoginOtpResponseModel? userLoginOtpResponseModel;
  String isFrom = '';

  Future getData() async {
    if (Get.arguments['isFrom'] == 'EditScreen') {
      propertiesFormScreenController.getAllPropertyData =
          Get.arguments['ModelData'];
    }
    await propertiesFormScreenController.getStateData();
    if (preferences
        .getString(SharedPreference.userData)
        .toString()
        .isNotEmpty) {
      userLoginOtpResponseModel = UserLoginOtpResponseModel.fromJson(json
          .decode(preferences.getString(SharedPreference.userData).toString()));
      propertiesFormScreenController.nameController.text =
          userLoginOtpResponseModel?.firstName ?? '';
      propertiesFormScreenController.phoneController.text =
          userLoginOtpResponseModel?.mobileNumber ?? '';
    }
  }

  SubCategoryResponseModel selectedData = Get.arguments['SubCategory'];

  @override
  void initState() {
    getData();
    isFrom = Get.arguments['isFrom'];
    propertiesFormScreenController.clearData();
    if (isFrom == 'EditScreen') {
      propertiesFormScreenController.assignData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    @override
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return AppContainer(
      child: GetBuilder<PropertiesFormScreenController>(
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: whiteColor,
              appBar: CommonAppBar(w: w, h: h, title: AppString.postAddText),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.045),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (h * 0.02).addHSpace(),
                      AppString.formCategoryText
                          .boldMontserratTextStyle(fontSize: 21),
                      (h * 0.02).addHSpace(),
                      Row(
                        children: [
                          SizedBox(
                            width: w * 0.65,
                            child: "${selectedData.subCategoryName}"
                                .toString()
                                .semiBoldMontserratTextStyle(
                                  textOverflow: TextOverflow.ellipsis,
                                  maxLine: 5,
                                  fontColor: blackColor,
                                  fontSize: 17,
                                ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.back();
                            },
                            child: Container(
                              height: h * 0.040,
                              width: h * 0.1,
                              decoration: BoxDecoration(
                                color: appColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: AppString.changeText
                                    .semiBoldMontserratTextStyle(
                                  fontColor: whiteColor,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(thickness: 1, height: h * 0.04),
                      AppString.formTitleText
                          .toString()
                          .semiBoldMontserratTextStyle(
                            fontColor: blackColor,
                            fontSize: 19,
                          ),
                      selectedData.subCategoryName == "Others"
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// For Sale: Houses & Apartments  ||  For Rent: Houses & Apartments     ///   Screen
                                selectedData.subCategoryName ==
                                            "For Sale: Houses & Apartments" ||
                                        selectedData.subCategoryName ==
                                            "For Rent: Houses & Apartments"
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ///Type
                                          (h * 0.02).addHSpace(),
                                          AppString.type
                                              .toString()
                                              .w500MontserratTextStyle(
                                                fontColor: blackColor,
                                                fontSize: 16,
                                              ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.propertiesList,
                                              selectType: controller.propType,
                                              fieldName: 'propType',
                                            ),
                                          ),

                                          ///furnishing
                                          AppString.furnishing
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.furnishingList,
                                              selectType:
                                                  controller.furnishType,
                                              fieldName: 'furnishType',
                                            ),
                                          ),

                                          ///bedrooms
                                          AppString.bedrooms
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.bedroomsList,
                                              selectType:
                                                  controller.bedroomType,
                                              fieldName: 'bedroomType',
                                            ),
                                          ),

                                          ///bathrooms
                                          AppString.bathrooms
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.bathroomsList,
                                              selectType:
                                                  controller.bathroomType,
                                              fieldName: 'bathroomType',
                                            ),
                                          ),

                                          ///construction Status
                                          AppString.constructionStatus
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList: controller
                                                  .constructionStatusList,
                                              selectType:
                                                  controller.constructionStatus,
                                              fieldName: 'constructStatusType',
                                            ),
                                          ),

                                          ///listedBy
                                          AppString.listedBy
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.listedTypeList,
                                              selectType:
                                                  controller.listedByType,
                                              fieldName: 'listedByType',
                                            ),
                                          ),

                                          /// Super Builtup area
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: h * 0.02,
                                            ),
                                            child: AppSearchBar.formTextField(
                                              textInputType:
                                                  TextInputType.number,
                                              controller:
                                                  controller.superBuildUpArea,
                                              labelText: AppString
                                                  .superBuiltupArea
                                                  .semiBoldMontserratTextStyle(),
                                              suffixIcon: IconButton(
                                                splashRadius: 1,
                                                onPressed: () {
                                                  controller
                                                      .clearControllerValue(
                                                    controller.superBuildUpArea,
                                                  );
                                                },
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ),
                                          ),

                                          /// Carpet area
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: h * 0.02,
                                            ),
                                            child: AppSearchBar.formTextField(
                                              textInputType:
                                                  TextInputType.number,
                                              controller: controller.carpetArea,
                                              labelText: AppString.carpetArea
                                                  .semiBoldMontserratTextStyle(),
                                              suffixIcon: IconButton(
                                                splashRadius: 1,
                                                onPressed: () {
                                                  controller
                                                      .clearControllerValue(
                                                    controller.carpetArea,
                                                  );
                                                },
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ),
                                          ),

                                          ///bachelorsAllowed
                                          selectedData.subCategoryName ==
                                                  "For Rent: Houses & Apartments"
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppString.bachelorsAllowed
                                                        .toString()
                                                        .w500MontserratTextStyle(
                                                            fontColor:
                                                                blackColor,
                                                            fontSize: 16),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  h * 0.015),
                                                      child: fieldSelection(
                                                        controller: controller,
                                                        selectTypeList: controller
                                                            .bachelorsAllowed,
                                                        selectType: controller
                                                            .bachelorAllow,
                                                        fieldName:
                                                            'bachelorAllow',
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),

                                          /// Maintenance monthaly
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: h * 0.02,
                                            ),
                                            child: AppSearchBar.formTextField(
                                              textInputType:
                                                  TextInputType.number,
                                              controller:
                                                  controller.maintenance,
                                              labelText: AppString
                                                  .maintenanceMonthly
                                                  .semiBoldMontserratTextStyle(),
                                              suffixIcon: IconButton(
                                                splashRadius: 1,
                                                onPressed: () {
                                                  controller
                                                      .clearControllerValue(
                                                    controller.maintenance,
                                                  );
                                                },
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ),
                                          ),

                                          /// Total Floors
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: h * 0.02,
                                            ),
                                            child: AppSearchBar.formTextField(
                                              textInputType:
                                                  TextInputType.number,
                                              controller:
                                                  controller.totalFloors,
                                              labelText: AppString.totalFloors
                                                  .semiBoldMontserratTextStyle(),
                                              suffixIcon: IconButton(
                                                splashRadius: 1,
                                                onPressed: () {
                                                  controller
                                                      .clearControllerValue(
                                                    controller.totalFloors,
                                                  );
                                                },
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ),
                                          ),

                                          /// Floor No
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: h * 0.02,
                                            ),
                                            child: AppSearchBar.formTextField(
                                              textInputType:
                                                  TextInputType.number,
                                              controller: controller.floorNo,
                                              labelText: AppString.floorNo
                                                  .semiBoldMontserratTextStyle(),
                                              suffixIcon: IconButton(
                                                splashRadius: 1,
                                                onPressed: () {
                                                  controller
                                                      .clearControllerValue(
                                                    controller.floorNo,
                                                  );
                                                },
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ),
                                          ),

                                          /// Car Parking
                                          AppString.carParking
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.carParking,
                                              selectType: controller.carPark,
                                              fieldName: 'carPark',
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),

                                /// Lands & Plot |||  Screen

                                selectedData.subCategoryName == "Lands & Plot"
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          (h * 0.02).addHSpace(),
                                          AppString.serviceType
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),

                                          ///serviceType
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.serviceList,
                                              selectType:
                                                  controller.serviceTypeSelect,
                                              fieldName: 'serviceTypeSelect',
                                            ),
                                          ),
                                          AppString.listedBy
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),

                                          ///listedBySe
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.listedTypeList,
                                              selectType:
                                                  controller.listedByType,
                                              fieldName: 'listedByType',
                                            ),
                                          ),

                                          ///ploatArea
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: h * 0.02,
                                            ),
                                            child: AppSearchBar.formTextField(
                                              textInputType:
                                                  TextInputType.number,
                                              controller: controller.ploatArea,
                                              labelText: AppString.ploatAreaText
                                                  .semiBoldMontserratTextStyle(),
                                              suffixIcon: IconButton(
                                                splashRadius: 1,
                                                onPressed: () {
                                                  controller
                                                      .clearControllerValue(
                                                    controller.ploatArea,
                                                  );
                                                },
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ),
                                          ),

                                          ///length
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: h * 0.02,
                                            ),
                                            child: AppSearchBar.formTextField(
                                              textInputType:
                                                  TextInputType.number,
                                              controller:
                                                  controller.lengthController,
                                              labelText: AppString.lengthText
                                                  .semiBoldMontserratTextStyle(),
                                              suffixIcon: IconButton(
                                                splashRadius: 1,
                                                onPressed: () {
                                                  controller
                                                      .clearControllerValue(
                                                    controller.lengthController,
                                                  );
                                                },
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ),
                                          ),

                                          ///breadth
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: h * 0.02,
                                            ),
                                            child: AppSearchBar.formTextField(
                                              textInputType:
                                                  TextInputType.number,
                                              controller:
                                                  controller.breadthController,
                                              labelText: AppString.breadthText
                                                  .semiBoldMontserratTextStyle(),
                                              suffixIcon: IconButton(
                                                splashRadius: 1,
                                                onPressed: () {
                                                  controller
                                                      .clearControllerValue(
                                                    controller
                                                        .breadthController,
                                                  );
                                                },
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),

                                /// For Rent: Shop & Offices |||  Screen

                                selectedData.subCategoryName ==
                                            "For Rent: Shop & Offices" ||
                                        selectedData.subCategoryName ==
                                            "For Sale: Shops & Offices"
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          (h * 0.02).addHSpace(),
                                          AppString.furnishing
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),

                                          ///furnishType
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.furnishingList,
                                              selectType:
                                                  controller.furnishType,
                                              fieldName: 'furnishType',
                                            ),
                                          ),
                                          AppString.bathrooms
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),

                                          ///bathroomType
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.bathroomsList,
                                              selectType:
                                                  controller.bathroomType,
                                              fieldName: 'bathroomType',
                                            ),
                                          ),

                                          ///constructionStatus
                                          selectedData.subCategoryName ==
                                                  "For Sale: Shops & Offices"
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    AppString.constructionStatus
                                                        .toString()
                                                        .w500MontserratTextStyle(
                                                            fontColor:
                                                                blackColor,
                                                            fontSize: 16),

                                                    ///listedBySe
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  h * 0.015),
                                                      child: fieldSelection(
                                                        controller: controller,
                                                        selectTypeList: controller
                                                            .constructionStatusList,
                                                        selectType: controller
                                                            .constructionStatus,
                                                        fieldName:
                                                            'constructStatusType',
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),

                                          ///listedBy
                                          AppString.listedBy
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.listedTypeList,
                                              selectType:
                                                  controller.listedByType,
                                              fieldName: 'listedByType',
                                            ),
                                          ),

                                          ///superBuildUpArea
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: h * 0.02,
                                            ),
                                            child: AppSearchBar.formTextField(
                                              textInputType:
                                                  TextInputType.number,
                                              controller:
                                                  controller.superBuildUpArea,
                                              labelText: AppString
                                                  .superBuiltupArea
                                                  .semiBoldMontserratTextStyle(),
                                              suffixIcon: IconButton(
                                                splashRadius: 1,
                                                onPressed: () {
                                                  controller
                                                      .clearControllerValue(
                                                    controller.superBuildUpArea,
                                                  );
                                                },
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ),
                                          ),

                                          ///carpetArea
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: h * 0.02,
                                            ),
                                            child: AppSearchBar.formTextField(
                                              textInputType:
                                                  TextInputType.number,
                                              controller: controller.carpetArea,
                                              labelText: AppString.carpetArea
                                                  .semiBoldMontserratTextStyle(),
                                              suffixIcon: IconButton(
                                                splashRadius: 1,
                                                onPressed: () {
                                                  controller
                                                      .clearControllerValue(
                                                    controller.carpetArea,
                                                  );
                                                },
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ),
                                          ),

                                          /// carpetArea
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: h * 0.02,
                                            ),
                                            child: AppSearchBar.formTextField(
                                              textInputType:
                                                  TextInputType.number,
                                              controller:
                                                  controller.maintenance,
                                              labelText: AppString
                                                  .maintenanceMonthly
                                                  .semiBoldMontserratTextStyle(),
                                              suffixIcon: IconButton(
                                                splashRadius: 1,
                                                onPressed: () {
                                                  controller
                                                      .clearControllerValue(
                                                    controller.maintenance,
                                                  );
                                                },
                                                icon: const Icon(Icons.cancel),
                                              ),
                                            ),
                                          ),

                                          AppString.carParking
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),

                                          ///listedBySe
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.carParking,
                                              selectType: controller.carPark,
                                              fieldName: 'carPark',
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),

                                selectedData.subCategoryName ==
                                        "PG & Guest Houses"
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          (h * 0.02).addHSpace(),
                                          AppString.subTypeText
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),

                                          ///subType
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.pgTypeList,
                                              selectType: controller.pgType,
                                              fieldName: 'subTypeSelectPG',
                                            ),
                                          ),

                                          ///furnishing
                                          AppString.furnishing
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),

                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.furnishingList,
                                              selectType:
                                                  controller.furnishType,
                                              fieldName: 'furnishType',
                                            ),
                                          ),

                                          ///listedBy
                                          AppString.listedBy
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),

                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.listedTypeList,
                                              selectType:
                                                  controller.listedByType,
                                              fieldName: 'listedByType',
                                            ),
                                          ),

                                          ///mealsIncluded
                                          AppString.mealsIncludedText
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),

                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.mealsIncludedList,
                                              selectType: controller
                                                  .mealsIncludedSelect,
                                              fieldName: 'mealsIncludedSelect',
                                            ),
                                          ),

                                          AppString.carParking
                                              .toString()
                                              .w500MontserratTextStyle(
                                                  fontColor: blackColor,
                                                  fontSize: 16),

                                          ///listedBySe
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: h * 0.015),
                                            child: fieldSelection(
                                              controller: controller,
                                              selectTypeList:
                                                  controller.carParking,
                                              selectType: controller.carPark,
                                              fieldName: 'carPark',
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),

                                selectedData.subCategoryName ==
                                            "For Rent: Shop & Offices" ||
                                        selectedData.subCategoryName ==
                                            "For Sale: Shops & Offices" ||
                                        selectedData.subCategoryName ==
                                            "PG & Guest Houses"
                                    ? const SizedBox()
                                    : Padding(
                                        padding:
                                            EdgeInsets.only(top: h * 0.015),
                                        child: AutoCorrectField(
                                          initialValue: TextEditingValue(
                                            text: isFrom == 'EditScreen'
                                                ? (controller
                                                                .getAllPropertyData[
                                                                    0]
                                                                .facingType !=
                                                            null &&
                                                        controller
                                                                .getAllPropertyData[
                                                                    0]
                                                                .facingType !=
                                                            0)
                                                    ? controller
                                                        .facingList[controller
                                                            .getAllPropertyData[
                                                                0]
                                                            .facingType! -
                                                        1]
                                                    : ''
                                                : '',
                                          ),
                                          optionList: controller.facingList,
                                          label: AppString.facingText,
                                          onSelected: (selection) async {
                                            controller.facing = selection;
                                            controller.selectFacingId =
                                                controller.facingList
                                                        .indexOf(selection) +
                                                    1;

                                            controller.update();
                                          },
                                        ),
                                      ),

                                /// Project Name
                                selectedData.subCategoryName ==
                                        "PG & Guest Houses"
                                    ? const SizedBox()
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: h * 0.02,
                                        ),
                                        child: AppSearchBar.formTextField(
                                          textInputType: TextInputType.text,
                                          controller: controller.projectName,
                                          labelText: AppString.projName
                                              .semiBoldMontserratTextStyle(),
                                          suffixIcon: IconButton(
                                            splashRadius: 1,
                                            onPressed: () {
                                              controller.clearControllerValue(
                                                controller.projectName,
                                              );
                                            },
                                            icon: const Icon(Icons.cancel),
                                          ),
                                        ),
                                      ),
                              ],
                            ),

                      /// Title
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: h * 0.02,
                        ),
                        child: AppSearchBar.formTextField(
                          textInputType: TextInputType.text,
                          controller: controller.titleController,
                          labelText:
                              AppString.title.semiBoldMontserratTextStyle(),
                          hintText: AppString.enterTitle,
                          suffixIcon: IconButton(
                            splashRadius: 1,
                            onPressed: () {
                              controller.clearControllerValue(
                                controller.titleController,
                              );
                            },
                            icon: const Icon(Icons.cancel),
                          ),
                        ),
                      ),

                      /// Description
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: h * 0.02,
                        ),
                        child: DescriptionTextField(
                          controller: controller.descriptionController,
                          hintText: AppString.enterDescription,
                          labelText: AppString.description,
                          maxLines: 7,
                          suffixIcon: IconButton(
                            splashRadius: 1,
                            onPressed: () {
                              controller.clearControllerValue(
                                  controller.descriptionController);
                            },
                            icon: const Icon(Icons.cancel),
                          ),
                        ),
                      ),

                      AppString.setPriceText
                          .toString()
                          .semiBoldMontserratTextStyle(
                              fontColor: blackColor, fontSize: 19),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: h * 0.02),
                        child: AppSearchBar.formTextField(
                          textInputType: TextInputType.number,
                          controller: controller.priceController,
                          labelText:
                              AppString.priceText.semiBoldMontserratTextStyle(),
                          hintText: AppString.enterPriceText,
                          suffixIcon: IconButton(
                            splashRadius: 1,
                            onPressed: () {
                              controller.clearControllerValue(
                                controller.priceController,
                              );
                            },
                            icon: const Icon(Icons.cancel),
                          ),
                        ),
                      ),
                      Divider(thickness: 1, height: h * 0.04),

                      AppString.uploadPhotoText
                          .toString()
                          .semiBoldMontserratTextStyle(
                              fontColor: blackColor, fontSize: 18),
                      (h * 0.02).addHSpace(),
                      ReorderableGridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: controller.propertiesImageList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == controller.propertiesImageList.length) {
                            return GestureDetector(
                              key: const ValueKey('add_button'),
                              onTap: () {
                                if (controller.propertiesImageList.length <=
                                    9) {
                                  controller.getImages(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: AppString.maximumphotoText
                                          .w500MontserratTextStyle(
                                              fontColor: whiteColor),
                                    ),
                                  );
                                }
                              },
                              child: controller.propertiesImageList.length == 10
                                  ? const SizedBox()
                                  : Container(
                                      height: h * 0.1,
                                      width: h * 0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: appColor),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.camera_alt_outlined,
                                            color: appColor,
                                            size: 28,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: h * 0.008),
                                            child: AppString.addPhotoText
                                                .semiBoldMontserratTextStyle(
                                                    fontColor: appColor,
                                                    fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                            );
                          } else {
                            return GridTile(
                              key: ValueKey(
                                  controller.propertiesImageList[index]),
                              child: Container(
                                height: h * 0.14,
                                width: h * 0.14,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: greyColor, width: 0.7),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      controller.propertiesImageList[index],
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.removePhoto(index);
                                          },
                                          child: Container(
                                            height: h * 0.030,
                                            width: h * 0.030,
                                            decoration: BoxDecoration(
                                              color: redColor,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: whiteColor,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    index == 0
                                        ? Container(
                                            height: h * 0.033,
                                            decoration: const BoxDecoration(
                                              color: blueAccentColor,
                                            ),
                                            child: Center(
                                              child: AppString.coverPhotoText
                                                  .semiBoldMontserratTextStyle(
                                                      fontColor: whiteColor,
                                                      fontSize: 13),
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        onReorder: (int oldIndex, int newIndex) {
                          controller.reorderImages(newIndex, oldIndex);
                        },
                      ),

                      Divider(thickness: 1, height: h * 0.04),
                      SizedBox(height: h * 0.02),
                      AppString.confirmLocationText
                          .toString()
                          .semiBoldMontserratTextStyle(
                              fontColor: blackColor, fontSize: 19),
                      SizedBox(height: h * 0.01),
                      SizedBox(
                        height: h * 0.05,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title: AppString.confirmLocationByPincodeText
                              .toString()
                              .semiBoldMontserratTextStyle(
                                  fontColor: blackColor, fontSize: 16),
                          value: 0,
                          groupValue: controller.confirmLocation,
                          activeColor: appColor,
                          onChanged: (int? value) {
                            controller.confirmLocation = value!;
                            controller.update();
                          },
                        ),
                      ),
                      SizedBox(
                        height: h * 0.05,
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          title: AppString.selectYourLocationText
                              .toString()
                              .semiBoldMontserratTextStyle(
                                  fontColor: blackColor, fontSize: 16),
                          value: 1,
                          activeColor: appColor,
                          groupValue: controller.confirmLocation,
                          onChanged: (int? value) {
                            controller.confirmLocation = value!;
                            controller.getPincodeDetailsResponseModel.clear();
                            controller.nearByController.clear();
                            controller.update();
                          },
                        ),
                      ),

                      SizedBox(height: h * 0.03),
                      controller.confirmLocation == 0
                          ? Column(
                              children: [
                                AppSearchBar.formTextField(
                                  maxLength: 6,
                                  textInputType: TextInputType.number,
                                  controller: controller.pinCodeController,
                                  labelText: AppString.pincodeText
                                      .semiBoldMontserratTextStyle(
                                          fontColor: Colors.grey),
                                  hintText: AppString.enterPincodeText,
                                  onChanged: (value) {
                                    if (value.length == 6) {
                                      controller.nearByController.clear();
                                      controller.getPincodeData(
                                          pincode: controller
                                              .pinCodeController.text);
                                    }
                                  },
                                ),
                                controller.getPincodeDetailsResponseModel
                                        .isNotEmpty
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: AppSearchBar.formTextField(
                                              readOnly: true,
                                              textInputType:
                                                  TextInputType.number,
                                              controller:
                                                  controller.stateController,
                                              labelText: AppString.stateText
                                                  .semiBoldMontserratTextStyle(
                                                fontColor: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          AppSearchBar.formTextField(
                                            readOnly: true,
                                            textInputType: TextInputType.number,
                                            controller:
                                                controller.cityController,
                                            labelText: AppString.cityText
                                                .semiBoldMontserratTextStyle(
                                              fontColor: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          AppSearchBar.formTextField(
                                            readOnly: true,
                                            controller:
                                                controller.nearByController,
                                            hintText: AppString.nearByStoreText,
                                            hintStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600,
                                              decoration: TextDecoration.none,
                                            ),
                                            suffixIcon: AppDropDown(
                                              hint: controller.nearByController
                                                      .text.isEmpty
                                                  ? 'NearBy Store'
                                                      .semiBoldMontserratTextStyle(
                                                      fontColor: Colors.grey,
                                                    )
                                                  : Text(
                                                      controller
                                                          .nearByController
                                                          .text,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        decoration:
                                                            TextDecoration.none,
                                                      ),
                                                    ),
                                              formScreen: true,
                                              borderColor:
                                                  blackColor.withOpacity(0.5),
                                              values: controller.nearBySelect
                                                  .toString(),
                                              valueList: controller
                                                  .getPincodeDetailsResponseModel
                                                  .first
                                                  .postOffice!
                                                  .map((e) => e.name)
                                                  .toList(),
                                              onChanged: (value) async {
                                                controller.nearByController
                                                    .text = value.toString();
                                                controller.nearBySelect =
                                                    value.toString();
                                                controller.update();
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            )
                          : Column(
                              children: [
                                AutoCorrectField(
                                  optionList: controller.stateList,
                                  label: AppString.stateText,
                                  onSelected: (selection) async {
                                    controller.getAllCityResponseModel.clear();
                                    controller.stateSelect = selection;
                                    await controller
                                        .stateId()
                                        .then((value) async {
                                      await controller.getCityData(
                                          controller.stateIdSelect.toString());
                                    });
                                    debugPrint('You just selected$selection');
                                    controller.update();
                                  },
                                  onChanged: (val) {
                                    controller.getAllCityResponseModel.clear();
                                    controller.getAllNearByResponseModel
                                        .clear();
                                    controller.citySelect = '';
                                    controller.nearBySelect = '';
                                    controller.update();
                                  },
                                ),
                                controller.getAllCityResponseModel.isNotEmpty
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top: h * 0.011, bottom: h * 0.011),
                                        child: AutoCorrectField(
                                          optionList: controller.cityList,
                                          label: AppString.cityText,
                                          onSelected: (selection) async {
                                            controller.citySelect = selection;
                                            await controller
                                                .cityId()
                                                .then((value) async {
                                              await controller.getNearByData(
                                                  controller.cityIdSelect
                                                      .toString());
                                            });
                                            controller.update();
                                          },
                                          onChanged: (val) {
                                            controller.getAllNearByResponseModel
                                                .clear();
                                            controller.nearBySelect = "";
                                            controller.update();
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
                                controller.getAllNearByResponseModel.isNotEmpty
                                    ? AutoCorrectField(
                                        optionList: controller.nearByList,
                                        label: AppString.nearByText,
                                        onSelected: (selection) async {
                                          controller.nearBySelect = selection;
                                          controller.update();
                                        },
                                        onChanged: (val) {},
                                      )
                                    : controller.citySelect.isNotEmpty
                                        ? AutoCorrectField(
                                            optionList: controller.nearByList,
                                            label: AppString.nearByText,
                                            onSelected: (selection) async {
                                              controller.nearBySelect =
                                                  selection;
                                              controller.update();
                                            },
                                            onChanged: (val) {
                                              controller
                                                  .getAllNearByResponseModel
                                                  .clear();
                                              controller.nearBySelect = '';
                                              controller.update();
                                            },
                                          )
                                        : const SizedBox()
                              ],
                            ),
                      Divider(thickness: 1, height: h * 0.04),
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.02),
                        child: AppString.reviewText
                            .toString()
                            .semiBoldMontserratTextStyle(
                                fontColor: blackColor, fontSize: 19),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: h * 0.02, horizontal: 2),
                        child: FormScreenReviewDetails(
                          nameController: controller.nameController,
                          numberController: controller.phoneController,
                          pickImageOnTap: () {
                            controller.pickImage();
                          },
                        ),
                      ),
                      Divider(thickness: 1, height: h * 0.04),
                      Padding(
                        padding: EdgeInsets.only(bottom: h * 0.02),
                        child: Obx(
                          () => controller.isLoading.value
                              ? Padding(
                                  padding: EdgeInsets.only(bottom: h * 0.02),
                                  child:
                                      const Center(child: AppLoadingWidget()),
                                )
                              : AppFilledButton(
                                  onPressed: () async {
                                    controller.isValidate = false;
                                    if (controller.confirmLocation == 0) {
                                      if (controller
                                          .stateController.text.isEmpty) {
                                        controller.isValidate = true;
                                      } else if (controller
                                          .cityController.text.isEmpty) {
                                        controller.isValidate = true;
                                      } else if (controller
                                          .nearByController.text.isEmpty) {
                                        controller.isValidate = true;
                                      }
                                    } else {
                                      if (controller.stateSelect.isEmpty) {
                                        controller.isValidate = true;
                                      } else if (controller
                                          .citySelect.isEmpty) {
                                        controller.isValidate = true;
                                      } else if (controller
                                          .nearBySelect.isEmpty) {
                                        controller.isValidate = true;
                                      }
                                    }
                                    if (controller
                                        .titleController.text.isEmpty) {
                                      showErrorSnackBar(
                                          AppString.enterTitleText);
                                    } else if (controller
                                        .descriptionController.text.isEmpty) {
                                      showErrorSnackBar(
                                          AppString.enterdescriptionText);
                                    } else if (controller
                                        .priceController.text.isEmpty) {
                                      showErrorSnackBar(
                                          AppString.enterpriceText);
                                    } else if (controller
                                        .propertiesImageList.isEmpty) {
                                      showErrorSnackBar(
                                          AppString.selectImageText);
                                    } else if (controller.isValidate == true) {
                                      if (controller.confirmLocation == 0) {
                                        if (controller
                                            .stateController.text.isEmpty) {
                                          showErrorSnackBar(
                                              AppString.enterstateText);
                                        } else if (controller
                                            .cityController.text.isEmpty) {
                                          showErrorSnackBar(
                                              AppString.entercityText);
                                        } else if (controller
                                            .nearByController.text.isEmpty) {
                                          showErrorSnackBar(
                                              AppString.enternearByText);
                                        }
                                      } else {
                                        if (controller.stateSelect.isEmpty) {
                                          showErrorSnackBar(
                                              AppString.enterstateText);
                                        } else if (controller
                                            .citySelect.isEmpty) {
                                          showErrorSnackBar(
                                              AppString.entercityText);
                                        } else if (controller
                                            .nearBySelect.isEmpty) {
                                          showErrorSnackBar(
                                              AppString.enternearByText);
                                        }
                                      }
                                    } else if (controller
                                        .nameController.text.isEmpty) {
                                      showErrorSnackBar(
                                          AppString.enterNameText);
                                    } else if (controller
                                        .phoneController.text.isEmpty) {
                                      showErrorSnackBar(
                                          AppString.enterphoneText);
                                    } else {
                                      List<Map<String, dynamic>>
                                          propertyImageList = [];
                                      await controller.uploadPropertyImages(
                                          requestData:
                                              controller.propertiesImageList);
                                      if (controller
                                          .imagePropertyUrl.isNotEmpty) {
                                        for (var element
                                            in controller.imagePropertyUrl) {
                                          propertyImageList.addAll({
                                            {
                                              "id": 0,
                                              "imageId": "",
                                              "imageURL": element,
                                              "propertyId": 0
                                            }
                                          });
                                        }
                                      }

                                      Map<String, dynamic> propertyData = {
                                        "categoryId": selectedData.categoryId,
                                        "title":
                                            controller.titleController.text,
                                        "discription": controller
                                            .descriptionController.text,
                                        "price":
                                            controller.priceController.text,
                                        "pincode":
                                            controller.pinCodeController.text,
                                        "state": controller.confirmLocation == 0
                                            ? controller.stateController.text
                                                .toString()
                                            : controller.stateSelect.toString(),
                                        "city": controller.confirmLocation == 0
                                            ? controller.cityController.text
                                                .toString()
                                            : controller.citySelect.toString(),
                                        "nearBy": controller.confirmLocation ==
                                                0
                                            ? controller.nearByController.text
                                                .toString()
                                            : controller.nearBySelect
                                                .toString(),
                                        "name": controller.nameController.text,
                                        "mobile":
                                            controller.phoneController.text,
                                        "isPremium": Get.arguments['isFrom'] ==
                                                'EditScreen'
                                            ? controller
                                                .getAllPropertyData[0].isPremium
                                            : false,
                                        "isActive": isFrom == 'EditScreen'
                                            ? controller
                                                .getAllPropertyData[0].isActive
                                            : false,
                                        "isVerified": isFrom == 'EditScreen'
                                            ? controller.getAllPropertyData[0]
                                                .isVerified
                                            : false,
                                        "createdBy": preferences
                                            .getInt(SharedPreference.userId),
                                        "createdOn": DateFormat(
                                                "yyyy-MM-dd'T'HH:mm:ss'Z'")
                                            .format(DateTime.now()),
                                        "modifiedBy": preferences
                                            .getInt(SharedPreference.userId),
                                        "modifiedOn": DateFormat(
                                                "yyyy-MM-dd'T'HH:mm:ss'Z'")
                                            .format(DateTime.now()),
                                        "tag": "",
                                        "tableRefGuid": isFrom == 'EditScreen'
                                            ? controller.getAllPropertyData[0]
                                                .tableRefGuid
                                            : "",
                                        "id": isFrom == 'EditScreen'
                                            ? controller
                                                .getAllPropertyData[0].id
                                            : 0,
                                        "propertyImageList": propertyImageList,
                                        "subCategoryId": selectedData.id,
                                        "houseType": controller.propTypeId ?? 0,
                                        "serviceType":
                                            controller.serviceTypeSelectId ?? 0,
                                        "bedrooms":
                                            controller.bedroomTypeId ?? 0,
                                        "bathrooms":
                                            controller.bathroomTypeId ?? 0,
                                        "furnishingStatus":
                                            controller.furnishTypeId ?? 0,
                                        "constructionStatus":
                                            controller.constructionStatusId ??
                                                0,
                                        "listedBy":
                                            controller.listedByTypeId ?? 0,
                                        "superBuildUpArea": controller
                                                .superBuildUpArea.text.isEmpty
                                            ? 0
                                            : int.parse(controller
                                                .superBuildUpArea.text),
                                        "carpetArea":
                                            controller.carpetArea.text.isEmpty
                                                ? 0
                                                : int.parse(
                                                    controller.carpetArea.text),
                                        "bachelorAllowed":
                                            controller.bachelorAllowId == 1
                                                ? true
                                                : false,
                                        "maintenanceCharge": controller
                                                .maintenance.text.isEmpty
                                            ? 0
                                            : int.parse(
                                                controller.maintenance.text),
                                        "totalFloors": controller
                                                .totalFloors.text.isEmpty
                                            ? 0
                                            : int.parse(
                                                controller.totalFloors.text),
                                        "floorNumber":
                                            controller.floorNo.text.isEmpty
                                                ? 0
                                                : int.parse(
                                                    controller.floorNo.text),
                                        "carParking": controller.carParkId ?? 0,
                                        "facingType":
                                            controller.selectFacingId ?? 0,
                                        "projectName":
                                            controller.projectName.text,
                                        "plotArea":
                                            controller.ploatArea.text.isEmpty
                                                ? 0
                                                : int.parse(
                                                    controller.ploatArea.text),
                                        "lenght": controller
                                                .lengthController.text.isEmpty
                                            ? 0
                                            : int.parse(controller
                                                .lengthController.text),
                                        "breadth": controller
                                                .breadthController.text.isEmpty
                                            ? 0
                                            : int.parse(controller
                                                .breadthController.text),
                                        "isMealIncluded":
                                            controller.mealsIncludedSelectId ==
                                                    1
                                                ? true
                                                : false,
                                        "pgType": controller.pgTypeId ?? 0
                                      };

                                      if (isFrom == 'FormScreen') {
                                        await controller.addPropertyData(
                                          propertyData: propertyData,
                                        );
                                      } else {
                                        controller.updatePropertiesData(
                                          id: controller
                                              .getAllPropertyData[0].id
                                              .toString(),
                                          updatePropertiesData: propertyData,
                                        );
                                      }
                                    }
                                  },
                                  title: AppString.publishNowText,
                                  textColor: whiteColor,
                                ),
                        ),
                      ),
                      SizedBox(height: h * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget fieldSelection({
    required List selectTypeList,
    required String fieldName,
    required String selectType,
    required PropertiesFormScreenController controller,
  }) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          selectTypeList.length,
          (index) => GestureDetector(
            onTap: () {
              if (fieldName == 'propType') {
                controller.propType = selectTypeList[index];
                controller.propTypeId = index + 1;
              } else if (fieldName == 'furnishType') {
                controller.furnishType = selectTypeList[index];
                controller.furnishTypeId = index + 1;
              } else if (fieldName == 'bedroomType') {
                controller.bedroomType = selectTypeList[index];
                controller.bedroomTypeId = index + 1;
              } else if (fieldName == 'bathroomType') {
                controller.bathroomType = selectTypeList[index];
                controller.bathroomTypeId = index + 1;
              } else if (fieldName == 'constructStatusType') {
                controller.constructionStatus = selectTypeList[index];
                controller.constructionStatusId = index + 1;
              } else if (fieldName == 'listedByType') {
                controller.listedByType = selectTypeList[index];
                controller.listedByTypeId = index + 1;
              } else if (fieldName == 'bachelorAllow') {
                controller.bachelorAllow = selectTypeList[index];
                controller.bachelorAllowId = index;
              } else if (fieldName == 'carPark') {
                controller.carPark = selectTypeList[index];
                controller.carParkId = index + 1;
              } else if (fieldName == 'serviceTypeSelect') {
                controller.serviceTypeSelect = selectTypeList[index];
                controller.serviceTypeSelectId = index + 1;
              } else if (fieldName == 'subTypeSelectPG') {
                controller.pgType = selectTypeList[index];
                controller.pgTypeId = index + 1;
              } else if (fieldName == 'mealsIncludedSelect') {
                controller.mealsIncludedSelect = selectTypeList[index];
                controller.mealsIncludedSelectId = index;
              }
              controller.update();
            },
            child: Container(
              height: h * 0.047,
              margin: EdgeInsets.symmetric(horizontal: w * 0.013),
              decoration: BoxDecoration(
                  color: selectType == selectTypeList[index]
                      ? Colors.indigo
                      : greyColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.011),
                    child: selectType == selectTypeList[index]
                        ? Icon(
                            Icons.check,
                            color: selectType == selectTypeList[index]
                                ? whiteColor
                                : blackColor,
                          )
                        : const SizedBox(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                    child: selectTypeList[index]
                        .toString()
                        .w500MontserratTextStyle(
                            fontColor: selectType == selectTypeList[index]
                                ? whiteColor
                                : blackColor,
                            fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
