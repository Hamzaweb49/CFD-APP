import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/ui/BottomBarScreen/Controller/bottom_bar_controller.dart';

import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:claxified_app/utils/app_routes.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCategoryScreenList extends StatefulWidget {
  const SelectCategoryScreenList({super.key});

  @override
  State<SelectCategoryScreenList> createState() =>
      _SelectCategoryScreenListState();
}

class _SelectCategoryScreenListState extends State<SelectCategoryScreenList> {
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());

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
            title: AppString.categories,
            w: w,
          ),
          body: GetBuilder<BottomNavBarController>(
            builder: (controller) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: h * 0.011),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.getAllCategoryResponseModel!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GetBuilder<ProductScreenController>(
                                builder: (productController) {
                              return GestureDetector(
                                onTap: () {
                                  productController
                                      .selectSeeAllDetailScreen(index);
                                  Get.toNamed(Routes.selectSubCategoriesScreen,
                                      arguments: {
                                        "select": controller
                                                .getAllCategoryResponseModel?[
                                            index],
                                        "screen": 'SeeAllScreen',
                                      });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(vertical: h * 0.003),
                                  child: ListTile(
                                    leading: assetImage(
                                      selectCategoryImage[index],
                                      scale: 14,
                                    ),
                                    title: controller
                                        .getAllCategoryResponseModel?[index]
                                        .categoryName
                                        .toString()
                                        .semiBoldMontserratTextStyle(
                                            fontColor: appColor),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                      color: blackColor,
                                    ),
                                  ),
                                ),
                              );
                            })
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
