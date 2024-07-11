import 'dart:convert';

import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/model/post_otp_login_response_model.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:flutter/material.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  UserLoginOtpResponseModel? userLoginOtpResponseModel;
  String userName = '';
  String userNo = '';

  Future getData() async {
    if (preferences
        .getString(SharedPreference.userData)
        .toString()
        .isNotEmpty) {
      userLoginOtpResponseModel = UserLoginOtpResponseModel.fromJson(json
          .decode(preferences.getString(SharedPreference.userData).toString()));
      userName = userLoginOtpResponseModel?.firstName ?? '';
      userNo = userLoginOtpResponseModel?.mobileNumber ?? '';
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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: CommonAppBar(
            h: h,
            w: w,
            title: AppString.personalInformationText,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.040),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: h * 0.02, bottom: h * 0.011),
                  child: AppString.userNameText.semiBoldMontserratTextStyle(),
                ),
                userName.w500MontserratTextStyle(),
                Divider(
                  thickness: 1,
                  height: h * 0.028,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: h * 0.0).copyWith(bottom: h * 0.011),
                  child: AppString.mobileNoText.semiBoldMontserratTextStyle(),
                ),
                userNo.w500MontserratTextStyle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
