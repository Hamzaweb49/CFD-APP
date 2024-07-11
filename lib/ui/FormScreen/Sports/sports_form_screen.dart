import 'dart:convert';
import 'dart:developer';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/model/post_otp_login_response_model.dart';
import 'package:claxified_app/model/sub_category_response_model.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:claxified_app/ui/FormScreen/Sports/sports_form_controller.dart';
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

class SportsFormScreen extends StatefulWidget {
  const SportsFormScreen({super.key});

  @override
  State<SportsFormScreen> createState() => _SportsFormScreenState();
}

class _SportsFormScreenState extends State<SportsFormScreen> {
  SportsFormController sportsFormController = Get.put(SportsFormController());

  SubCategoryResponseModel selectedData = Get.arguments['SubCategory'];
  UserLoginOtpResponseModel? userLoginOtpResponseModel;

  Future getData() async {
    if (Get.arguments['isFrom'] == 'EditScreen') {
      //   await gadgetFormScreenController.assignData(
      //       getAllGadgetResponseModel: Get.arguments['ModelData']);

      sportsFormController.getAllSportsData = Get.arguments['ModelData'];
    }
    await sportsFormController.getStateData();
    if (preferences
        .getString(SharedPreference.userData)
        .toString()
        .isNotEmpty) {
      userLoginOtpResponseModel = UserLoginOtpResponseModel.fromJson(json
          .decode(preferences.getString(SharedPreference.userData).toString()));
      sportsFormController.nameController.text =
          userLoginOtpResponseModel?.firstName ?? '';
      sportsFormController.phoneController.text =
          userLoginOtpResponseModel?.mobileNumber ?? '';
    }
  }

  @override
  void initState() {
    getData();
    sportsFormController.clearData();
    if (Get.arguments['isFrom'] == 'EditScreen') {
      sportsFormController.assignData();
    }
    super.initState();
  }

  @override
  void dispose() {
    sportsFormController.getAllNearByResponseModel = [];
    sportsFormController.getAllCityResponseModel = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('selectedData.categoryId----------- ${selectedData.categoryId}');
    log('selectedData.id----------- ${selectedData.id}');

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return AppContainer(
      child: GetBuilder<SportsFormController>(
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: whiteColor,
              appBar: CommonAppBar(
                w: w,
                h: h,
                title: AppString.postAddText,
              ),
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
                                    fontSize: 17),
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
                                        fontColor: whiteColor, fontSize: 13),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,
                        height: h * 0.04,
                      ),
                      AppString.detailsText
                          .toString()
                          .semiBoldMontserratTextStyle(
                              fontColor: blackColor, fontSize: 19),
                      SizedBox(height: h * 0.02),
                      AppSearchBar.formTextField(
                        textInputType: TextInputType.text,
                        hintText: AppString.enterTitle,
                        labelText: AppString.title
                            .semiBoldMontserratTextStyle(fontColor: blackColor),
                        controller: controller.titleController,
                        suffixIcon: IconButton(
                            splashRadius: 1,
                            onPressed: () {
                              controller.clearControllerValue(
                                  controller.titleController);
                            },
                            icon: const Icon(Icons.cancel)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: h * 0.02),
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
                              icon: const Icon(Icons.cancel)),
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
                                    controller.priceController);
                              },
                              icon: const Icon(Icons.cancel)),
                        ),
                      ),
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
                        itemCount: controller.addDataList.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == controller.addDataList.length) {
                            return GestureDetector(
                              key: const ValueKey('add_button'),
                              onTap: () {
                                if (controller.addDataList.length <= 9) {
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
                              child: controller.addDataList.length == 10
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
                              key: ValueKey(controller.addDataList[index]),
                              child: Container(
                                height: h * 0.14,
                                width: h * 0.14,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: greyColor, width: 0.7),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      controller.addDataList[index],
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
                                      controller.getPinCodeData(
                                          pinCode: controller
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
                                            controller.nearBySelect = '';
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
                                    } else if (controller.addDataList.isEmpty) {
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
                                          sportsDataImageList = [];
                                      await controller.uploadImages(
                                          requestData: controller.addDataList);

                                      if (controller.imageUrl.isNotEmpty) {
                                        for (var element
                                            in controller.imageUrl) {
                                          sportsDataImageList.addAll({
                                            {
                                              "id": 0,
                                              "imageId": "",
                                              "imageURL": element,
                                              "sportsId": 0
                                            }
                                          });
                                        }
                                      }

                                      Map<String, dynamic> sports = {
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
                                                .getAllSportsData[0].isPremium
                                            : false,
                                        "isActive": Get.arguments['isFrom'] ==
                                                'EditScreen'
                                            ? controller
                                                .getAllSportsData[0].isActive
                                            : false,
                                        "isVerified": Get.arguments['isFrom'] ==
                                                'EditScreen'
                                            ? controller
                                                .getAllSportsData[0].isVerified
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
                                        "tableRefGuid":
                                            Get.arguments['isFrom'] ==
                                                    'EditScreen'
                                                ? controller.getAllSportsData[0]
                                                    .tableRefGuid
                                                : "",
                                        "id": Get.arguments['isFrom'] ==
                                                'EditScreen'
                                            ? controller.getAllSportsData[0].id
                                            : 0,
                                        "subCategoryId": selectedData.id,
                                        "sportImageList": sportsDataImageList,
                                      };

                                      if (Get.arguments['isFrom'] ==
                                          'FormScreen') {
                                        await controller.addSportsData(
                                            sports: sports);
                                      } else {
                                        controller.updateSportsAllData(
                                          id: controller.getAllSportsData[0].id
                                              .toString(),
                                          sportsData: sports,
                                        );
                                      }
                                    }
                                  },
                                  title: AppString.publishNowText,
                                  textColor: whiteColor,
                                ),
                        ),
                      ),
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
}
