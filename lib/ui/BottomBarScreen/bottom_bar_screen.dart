import 'dart:async';
import 'dart:developer';
import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/ui/BottomBarScreen/Controller/bottom_bar_controller.dart';
import 'package:claxified_app/utils/app_routes.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:claxified_app/widgets/app_button.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:claxified_app/widgets/app_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  BottomNavBarController bottomNavBarController =
      Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return GetBuilder<BottomNavBarController>(
      builder: (controller) {
        return AppContainer(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: whiteColor,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(h * 0.075),
                child: Container(
                  height: h * 0.075,
                  color: appColor,
                  child: Row(
                    children: [
                      // assetImage(AppAssets.appLogo),
                      CachedNetworkImage(
                        imageUrl: AppAssets.appLogoUrl,
                        width: 50, // Adjust width as per your requirement
                        height: 50, // Adjust height as per your requirement
                      ),
                      AppString.appName
                          .boldMontserratTextStyle(fontColor: whiteColor),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: w * 0.030),
                        child: GestureDetector(
                          onTap: () {
                            if (preferences.getBool('isLogin') == true) {
                              Get.toNamed(Routes.selectCategoryScreenGrid);
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return buildWillPopScope('Appbar');
                                },
                              );
                            }
                          },
                          child: AppString.appbarHomePageText
                              .boldMontserratTextStyle(
                                  fontColor: secondaryAppColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body:

                  // controller.selected == 4 &&
                  //         preferences.getBool('isLogin') == false
                  //     ? buildWillPopScope('Profile')
                  //     :

                  bottomBarItems[controller.selected]['screen'],
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: keyboardIsOpened == true
                  ? const SizedBox()
                  : Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: whiteColor.withOpacity(0.0),
                              width: w * 0.0045)),
                      child: FloatingActionButton(
                        elevation: 0,
                        splashColor: Colors.transparent,
                        backgroundColor: appColor,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              w * 0.5), // Adjust the radius here
                        ),
                        child: IconButton(
                          splashRadius: 1,
                          hoverColor: Colors.transparent,
                          onPressed: () {
                            if (preferences.getBool('isLogin') == true) {
                              Get.toNamed(Routes.selectCategoryScreenGrid);
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return buildWillPopScope('Appbar');
                                },
                              );
                            }
                          },
                          icon: Icon(
                            Icons.add,
                            size: h * 0.046,
                            color: secondaryAppColor,
                          ),
                        ),
                      ),
                    ),
              bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: BottomAppBar(
                  color: appColor,
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 10,
                  child: Container(
                    height: h * 0.077,
                    padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        bottomBarItems.length,
                        (index) => index == 2
                            ? SizedBox(
                                width: w * 0.12,
                              )
                            : IconButton(
                                splashRadius: 1,
                                hoverColor: Colors.transparent,
                                onPressed: () {
                                  controller.changeTabs(index);
                                  if (preferences.getBool('isLogin') == false &&
                                      controller.selected == 4) {
                                    controller.changeTabs(0);
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return buildWillPopScope('Profile');
                                      },
                                    );
                                  } else if (controller.selected == 3) {
                                    controller.changeTabs(3);
                                    Get.toNamed(
                                        Routes.selectCategoryScreenList);
                                  }
                                },
                                icon: Icon(
                                  bottomBarItems[index]["icon"],
                                  size: h * 0.036,
                                  color: controller.selected == index
                                      ? secondaryAppColor
                                      : whiteColor,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildWillPopScope(String isFrom) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return WillPopScope(onWillPop: () async {
      return false;
    }, child: GetBuilder<BottomNavBarController>(
      builder: (controller) {
        return StatefulBuilder(
          builder: (context, setState12) {
            void startTimer() {
              controller.start = 30;
              if (controller.timer != null) {
                controller.timer!.cancel();
              }
              controller.timer =
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                if (controller.start == 0) {
                  if (mounted) {
                    setState12(() {
                      timer.cancel();
                    });
                  }
                } else {
                  controller.start--;
                  if (mounted) {
                    setState12(() {});
                  }
                }
              });
            }

            return Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: Form(
                key: controller.formKey,
                onChanged: () {},
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          splashRadius: 1,
                          onPressed: () {
                            controller.mobileController.clear();
                            controller.otpController.clear();
                            controller.nameController.clear();
                            controller.userMobile = false;
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 27,
                          ),
                        ),
                      ),
                      CachedNetworkImage(
                        imageUrl: AppAssets.appLogoUrl,
                        width: 50, // Adjust width as per your requirement
                        height: 50, // Adjust height as per your requirement
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.014),
                        child: AppString.loginOtp.boldMontserratTextStyle(
                            fontColor: blackColor, fontSize: 19),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.05,
                        ).copyWith(top: h * 0.03, bottom: h * 0.022),
                        child: TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          controller: controller.mobileController,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.none,
                          ),
                          validator: (value) {
                            if (controller.mobileController.text.isEmpty) {
                              return AppString.enterNumberText;
                            } else if (controller
                                    .mobileController.text.length !=
                                10) {
                              return AppString.enterValidNumberText;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            suffixIcon: const Icon(Icons.call),
                            prefixIcon: Padding(
                                padding: EdgeInsets.only(
                                    top: h * 0.014, left: w * 0.02),
                                child: AppString.noText
                                    .semiBoldMontserratTextStyle()),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            hintText: AppString.enterTendigitText,
                            hintStyle: const TextStyle(
                              color: Colors.black45,
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                      controller.userMobile == true
                          ? Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: w * 0.05)
                                          .copyWith(bottom: h * 0.02),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: AppString.resendOtpText
                                            .boldMontserratTextStyle(
                                                fontColor: Colors.grey,
                                                fontSize: h * 0.016),
                                      ),
                                      controller.start > 0
                                          ? 'Resend in ${controller.start}s'
                                              .boldMontserratTextStyle(
                                                  fontColor: appColor,
                                                  fontSize: h * 0.015)
                                          : GestureDetector(
                                              onTap: () async {
                                                Map<String, dynamic> sendOtp = {
                                                  "id": 0,
                                                  "otp": 0,
                                                  "ipAddress": "",
                                                  "isBlockedMobileNo": true,
                                                  "createdOn": DateFormat(
                                                          "yyyy-MM-dd'T'HH:mm:ss'Z'")
                                                      .format(DateTime.now()),
                                                  "mobile": controller
                                                      .mobileController.text,
                                                };
                                                await controller.postSendOtp(
                                                    sendOtp: sendOtp);
                                                startTimer();
                                              },
                                              child: "Resend"
                                                  .boldMontserratTextStyle(
                                                      textDecoration:
                                                          TextDecoration
                                                              .underline,
                                                      fontColor:
                                                          blueAccentColor,
                                                      fontSize: 14),
                                            ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: w * 0.05,
                                  ),
                                  child: TextFormField(
                                    maxLength: 4,
                                    keyboardType: TextInputType.number,
                                    controller: controller.otpController,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                    ),
                                    validator: (value) {
                                      if (controller
                                          .otpController.text.isEmpty) {
                                        return AppString.enterOtpText;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      counterText: "",
                                      suffixIcon: const Icon(
                                          CupertinoIcons.shield_fill),
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      hintText: AppString.otpText,
                                      hintStyle: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.05, vertical: h * 0.02),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: controller.nameController,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.none,
                                    ),
                                    validator: (value) {
                                      if (controller
                                          .nameController.text.isEmpty) {
                                        return AppString.enterNameText;
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: const Icon(Icons.person),
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      hintText: AppString.nameText,
                                      hintStyle: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      Obx(
                        () => controller.isLoading.value
                            ? Padding(
                                padding: EdgeInsets.only(bottom: h * 0.02),
                                child: const Center(child: AppLoadingWidget()),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: w * 0.05,
                                ).copyWith(bottom: h * 0.02, top: h * 0.015),
                                child: AppFilledButton(
                                  onPressed: () async {
                                    if (controller.formKey.currentState!
                                        .validate()) {
                                      Map<String, dynamic> sendOtp = {
                                        "id": 0,
                                        "otp": 0,
                                        "ipAddress": "",
                                        "isBlockedMobileNo": true,
                                        "createdOn": DateFormat(
                                                "yyyy-MM-dd'T'HH:mm:ss'Z'")
                                            .format(DateTime.now()),
                                        "mobile":
                                            controller.mobileController.text,
                                      };

                                      startTimer();
                                      controller.userMobile == true
                                          ? await controller.postLoginOtp(
                                              otp:
                                                  controller.otpController.text,
                                              mobileNo: controller
                                                  .mobileController.text,
                                              name: controller
                                                  .nameController.text,
                                              isFrom: isFrom,
                                            )
                                          : await controller.postSendOtp(
                                              sendOtp: sendOtp);
                                      setState12(() {});
                                    }
                                  },
                                  height: h * 0.06,
                                  title: controller.userMobile == true
                                      ? AppString.loginText
                                      : AppString.sendOTPText,
                                  textColor: whiteColor,
                                  buttonColor: appColor,
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ));
  }
}
