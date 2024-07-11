import 'dart:developer';

import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/ui/BottomBarScreen/Controller/bottom_bar_controller.dart';
import 'package:claxified_app/ui/FormScreen/Gadget/gadget_form_controller.dart';
import 'package:claxified_app/utils/app_routes.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCategoryScreenGrid extends StatefulWidget {
  const SelectCategoryScreenGrid({super.key});

  @override
  State<SelectCategoryScreenGrid> createState() =>
      _SelectCategoryScreenGridState();
}

class _SelectCategoryScreenGridState extends State<SelectCategoryScreenGrid> {
  BottomNavBarController bottomNavBarController =
      Get.put(BottomNavBarController());

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return AppContainer(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: CommonAppBar(
            backIcon: Padding(
              padding: EdgeInsets.only(left: w * 0.014),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: whiteColor,
                  size: 20,
                ),
              ),
            ),
            h: h,
            title: AppString.selectCategoriesText,
            w: w,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.040),
            child: GetBuilder<BottomNavBarController>(
              builder: (controller) {
                return GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      horizontal: w * 0.02, vertical: h * 0.016),
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.getAllCategoryResponseModel!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: h * 0.02,
                      mainAxisSpacing: h * 0.02,
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // formController.selectedFormCategory(index);
                        // formController.selectFormCategory = index;
                        Get.toNamed(
                          Routes.selectSubCategoriesScreen,
                          arguments: {
                            "select":
                                controller.getAllCategoryResponseModel?[index],
                            "screen": 'FormScreen',
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(h * 0.008),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: greyColor,
                              blurRadius: 1,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (h * 0.009).addHSpace(),
                            Expanded(
                              flex: 4,
                              child: assetImage(
                                selectCategoryImage[index],
                                scale: 14,
                              ),
                            ),
                            (h * 0.009).addHSpace(),
                            Expanded(
                              flex: 3,
                              child: controller
                                  .getAllCategoryResponseModel![index]
                                  .categoryName
                                  .toString()
                                  .semiBoldMontserratTextStyle(
                                      textAlign: TextAlign.center,
                                      fontColor: appColor,
                                      fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
