import 'dart:developer';

import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/model/get_all_category_response_model.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:claxified_app/utils/app_routes.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:claxified_app/widgets/app_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectSubCategoriesScreen extends StatefulWidget {
  const SelectSubCategoriesScreen({
    super.key,
  });

  @override
  State<SelectSubCategoriesScreen> createState() =>
      _SelectSubCategoriesScreenState();
}

class _SelectSubCategoriesScreenState extends State<SelectSubCategoriesScreen> {
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());
  GetAllCategoryResponseModel selectedData = Get.arguments['select'];
  String navigation = Get.arguments['screen'];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    await productScreenController.selectSubCategory(selectedData.id!);
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
            title: selectedData.categoryName.toString(),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.047),
            child: GetBuilder<ProductScreenController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: controller.isLoading.value
                          ? const AppLoadingWidget()
                          : controller.selectedCategoryResponseModel == null
                              ? const SizedBox()
                              : ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller
                                      .selectedCategoryResponseModel!.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider(
                                      thickness: 1,
                                      height: 0,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      onTap: () {
                                        controller.selectCategoryScreen(index);
                                        Get.toNamed(
                                          _getRouteName(),
                                          arguments: navigation == 'FormScreen'
                                              ? {
                                                  'SubCategory': controller
                                                          .selectedCategoryResponseModel?[
                                                      index],
                                                  'ModelData': [],
                                                  'isFrom': 'FormScreen'
                                                }
                                              : controller
                                                      .selectedCategoryResponseModel?[
                                                  index],
                                        );
                                      },
                                      leading: controller
                                          .selectedCategoryResponseModel?[index]
                                          .subCategoryName
                                          .toString()
                                          .semiBoldMontserratTextStyle(
                                            fontColor: appColor,
                                          ),
                                      trailing: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 14,
                                        color: blackColor,
                                      ),
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
      ),
    );
  }

  String _getRouteName() {
    switch (navigation) {
      case 'FormScreen':
        switch (selectedData.categoryName) {
          case 'Gadgets':
            return Routes.gadgetFormScreen;
          case 'Vehicles':
            return Routes.vehicleFormScreen;
          case 'Properties':
            return Routes.propertiesFormScreen;
          case 'Jobs':
            return Routes.jobsFormScreen;
          case 'Electronics':
            return Routes.electronicsFormScreen;
          case 'Furniture':
            return Routes.furnitureFormScreen;
          case 'Books':
            return Routes.bookFormScreen;
          case 'Commercial Services':
            return Routes.commercialServicesFormScreen;
          case 'Fashion':
            return Routes.fashionFormScreen;
          case 'Pets':
            return Routes.petFormScreen;
          case 'Sports':
            return Routes.sportsFormScreen;
          default:
            return Routes.jobsFormScreen;
        }
      default:
        switch (selectedData.categoryName) {
          case 'Gadgets':
            return Routes.gadgetProductScreen;
          case 'Vehicles':
            return Routes.vehicleProductScreen;
          case 'Properties':
            return Routes.propertiesProductScreen;
          case 'Jobs':
            return Routes.jobsProductScreen;
          case 'Electronics & Appliances':
            return Routes.electronicsProductScreen;
          case 'Furniture':
            return Routes.furnitureProductScreen;
          case 'Books':
            return Routes.bookProductScreen;
          case 'Commercial Services':
            return Routes.commercialServicesProductScreen;
          case 'Fashion':
            return Routes.fashionProductScreen;
          case 'Pets':
            return Routes.petProductScreen;
          case 'Sports & Hobbies':
            return Routes.sportsProductScreen;
          default:
            return Routes.jobsProductScreen;
        }
    }
  }
}
