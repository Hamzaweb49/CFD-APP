import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:claxified_app/widgets/app_text_fields.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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
            title: AppString.location,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.040),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: h * 0.016),
                  child: const AppSearchBar(
                    hintText: AppString.serachCityText,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_searching,
                              color: appColor,
                            ),
                            (w * 0.017).addWSpace(),
                            AppString.currentLocation
                                .semiBoldMontserratTextStyle(
                                    fontColor: appColor),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.078),
                          child: AppString.enableLocation
                              .regularMontserratTextStyle(
                                  fontColor: blackColor, fontSize: 14),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: h * 0.01, bottom: h * 0.004),
                          child: const Divider(thickness: 1),
                        ),
                        AppString.recently.regularMontserratTextStyle(
                            fontColor: appColor, fontSize: 14),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: h * 0.011),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: appColor,
                              ),
                              (w * 0.017).addWSpace(),
                              AppString.currentLocation
                                  .semiBoldMontserratTextStyle(
                                      fontColor: appColor),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: h * 0.004),
                          child: const Divider(thickness: 1),
                        ),
                        AppString.chooseState.regularMontserratTextStyle(
                            fontColor: appColor, fontSize: 14),
                        (h * 0.01).addHSpace(),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.012),
                          child: AppString.indiaText
                              .semiBoldMontserratTextStyle(
                                  fontColor: appColor, fontSize: 15),
                        ),
                        (h * 0.02).addHSpace(),
                        ListView.builder(
                          padding: EdgeInsets.only(top: h * 0.011),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: selectCategoryImage.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: h * 0.012),
                              child: Row(
                                children: [
                                  stateList[index]
                                      .toString()
                                      .regularMontserratTextStyle(
                                          fontColor: appColor),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: blackColor,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
