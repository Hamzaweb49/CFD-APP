import 'dart:convert';
import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/model/post_otp_login_response_model.dart';
import 'package:claxified_app/utils/app_routes.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserLoginOtpResponseModel? userLoginOtpResponseModel;
  String userName = "";

  Future getData() async {
    if (preferences
        .getString(SharedPreference.userData)
        .toString()
        .isNotEmpty) {
      userLoginOtpResponseModel = UserLoginOtpResponseModel.fromJson(json
          .decode(preferences.getString(SharedPreference.userData).toString()));
      userName = userLoginOtpResponseModel?.firstName ?? '';
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return AppContainer(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 0.017),
                child: ListTile(
                    leading: Container(
                        height: h * 0.065,
                        width: h * 0.065,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: assetImage(AppAssets.profile)),
                    title: userName.semiBoldMontserratTextStyle(fontSize: 20),
                    trailing: TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.personalInformationScreen);
                      },
                      child: AppString.goToPrifileText
                          .semiBoldMontserratTextStyle(
                              fontSize: 18,
                              textOverflow: TextOverflow.ellipsis,
                              maxLine: 2),
                    )),
              ),
              Divider(
                thickness: 1,
                height: h * 0.035,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.manageAdsScreen);
                      },
                      leading: Icon(
                        Icons.post_add_sharp,
                        size: h * 0.04,
                        color: blackColor,
                      ),
                      title: AppString.adsText
                          .w500MontserratTextStyle(fontSize: 20),
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.myWishListScreen);
                      },
                      leading: Icon(
                        Icons.favorite_border,
                        size: h * 0.04,
                        color: blackColor,
                      ),
                      title: AppString.myWishListText
                          .w500MontserratTextStyle(fontSize: 20),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.help,
                        size: h * 0.04,
                        color: blackColor,
                      ),
                      title: AppString.helpManualText
                          .w500MontserratTextStyle(fontSize: 20),
                    ),
                    ListTile(
                      onTap: () {
                        Get.toNamed(Routes.addFeedBackScreen);
                      },
                      leading: Icon(
                        Icons.feedback_outlined,
                        size: h * 0.04,
                        color: blackColor,
                      ),
                      title: AppString.feedBackText
                          .w500MontserratTextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                height: h * 0.028,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    size: h * 0.04,
                    color: blackColor,
                  ),
                  title: AppString.settingsText
                      .w500MontserratTextStyle(fontSize: 20),
                ),
              ),
              Divider(
                thickness: 1,
                height: h * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                child: ListTile(
                  onTap: () {
                    preferences.logOut();
                  },
                  leading: Icon(
                    Icons.logout,
                    size: h * 0.04,
                    color: blackColor,
                  ),
                  title: AppString.logoutText
                      .w500MontserratTextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
