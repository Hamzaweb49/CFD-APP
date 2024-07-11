import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/model/sub_category_response_model.dart';
import 'package:claxified_app/ui/BottomBarScreen/Controller/add_wishlist_controller.dart';
import 'package:claxified_app/ui/ProductScreen/CommercialServices/comercial_services_controller.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:claxified_app/utils/app_routes.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_button.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:claxified_app/widgets/app_drop_down.dart';
import 'package:claxified_app/widgets/app_text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CommercialServicesProductScreen extends StatefulWidget {
  const CommercialServicesProductScreen({
    super.key,
  });

  @override
  State<CommercialServicesProductScreen> createState() =>
      _CommercialServicesProductScreenState();
}

class _CommercialServicesProductScreenState
    extends State<CommercialServicesProductScreen> {
  CommercialServicesController commercialServicesController =
      Get.put(CommercialServicesController());
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());

  MyWishListController myWishListController = Get.put(MyWishListController());
  SubCategoryResponseModel? selectedData;

  Future getData() async {
    await commercialServicesController
        .getAllCommercialServices(Get.arguments?.id);
  }

  @override
  void initState() {
    selectedData = Get.arguments;
    getData();
    productScreenController.clearData();
    super.initState();
  }

  @override
  void dispose() {
    productScreenController.getAllNearByResponseModel = [];
    productScreenController.getAllCityResponseModel = [];
    productScreenController.nearByController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return AppContainer(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: whiteColor,
          appBar: CommonAppBar(
            h: h,
            w: w,
            title: selectedData?.subCategoryName ?? '',
          ),
          body: GetBuilder<CommercialServicesController>(
            builder: (controller) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.047),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.02),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: AppSearchBar(
                              controller: controller.searchController,
                              hintText: AppString.search,
                              onChanged: (value) {
                                controller.setCommercialServicesFilter();
                                controller.update();
                              },
                            ),
                          ),
                          (w * 0.035).addWSpace(),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(17),
                                      topLeft: Radius.circular(17),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return WillPopScope(
                                      onWillPop: () async {
                                        productScreenController.clearData();
                                        return true;
                                      },
                                      child: StatefulBuilder(
                                        builder: (context, setState1) {
                                          return Container(
                                            height: h * 0.89,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(17),
                                                topLeft: Radius.circular(17),
                                              ),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: w * 0.05),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                                  vertical:
                                                                      h * 0.02)
                                                              .copyWith(
                                                        top: h * 0.04,
                                                      ),
                                                      child: AppString
                                                          .filtersText
                                                          .boldMontserratTextStyle(
                                                              fontColor:
                                                                  appColor,
                                                              fontSize: 21),
                                                    ),
                                                    const Divider(
                                                        height: 0,
                                                        thickness: 0.8),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: h * 0.02),
                                                      child: AutoCorrectField(
                                                        suffixIcon:
                                                            const SizedBox(),
                                                        initialValue:
                                                            TextEditingValue(
                                                                text: productScreenController
                                                                    .stateSelect),
                                                        optionList:
                                                            productScreenController
                                                                .stateList,
                                                        label:
                                                            AppString.stateText,
                                                        onSelected:
                                                            (selection) async {
                                                          productScreenController
                                                                  .stateSelect =
                                                              selection;
                                                          productScreenController
                                                              .getAllCityResponseModel
                                                              .clear();
                                                          await productScreenController
                                                              .stateId()
                                                              .then(
                                                                  (value) async {
                                                            await productScreenController
                                                                .getCityData(
                                                                    productScreenController
                                                                        .stateIdSelect
                                                                        .toString());
                                                          });
                                                          debugPrint(
                                                              'You just selected$selection');
                                                          setState1(() {});
                                                        },
                                                        onChanged: (val) {
                                                          productScreenController
                                                              .getAllCityResponseModel
                                                              .clear();
                                                          productScreenController
                                                              .getAllNearByResponseModel
                                                              .clear();
                                                          productScreenController
                                                              .citySelect = '';
                                                          productScreenController
                                                              .nearBySelect = '';
                                                          setState1(() {});
                                                        },
                                                      ),
                                                    ),

                                                    productScreenController
                                                            .getAllCityResponseModel
                                                            .isNotEmpty
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: h * 0.011,
                                                            ),
                                                            child:
                                                                AutoCorrectField(
                                                              suffixIcon:
                                                                  const SizedBox(),
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text: productScreenController
                                                                          .citySelect),
                                                              optionList:
                                                                  productScreenController
                                                                      .cityList,
                                                              label: AppString
                                                                  .cityText,
                                                              onSelected:
                                                                  (selection) async {
                                                                productScreenController
                                                                        .citySelect =
                                                                    selection;
                                                                await productScreenController
                                                                    .cityId()
                                                                    .then(
                                                                        (value) async {
                                                                  await productScreenController.getNearByData(
                                                                      productScreenController
                                                                          .cityIdSelect
                                                                          .toString());
                                                                });
                                                                setState1(
                                                                    () {});
                                                              },
                                                              onChanged: (val) {
                                                                productScreenController
                                                                    .getAllNearByResponseModel
                                                                    .clear();
                                                                productScreenController
                                                                    .nearBySelect = '';
                                                                setState1(
                                                                    () {});
                                                              },
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                    productScreenController
                                                            .getAllNearByResponseModel
                                                            .isNotEmpty
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: h *
                                                                        0.011),
                                                            child:
                                                                AutoCorrectField(
                                                              suffixIcon:
                                                                  const SizedBox(),
                                                              initialValue:
                                                                  TextEditingValue(
                                                                      text: productScreenController
                                                                          .nearBySelect),
                                                              optionList:
                                                                  productScreenController
                                                                      .nearByList,
                                                              label: AppString
                                                                  .nearByText,
                                                              onSelected:
                                                                  (selection) async {
                                                                productScreenController
                                                                        .nearBySelect =
                                                                    selection;
                                                                setState1(
                                                                    () {});
                                                              },
                                                              onChanged:
                                                                  (val) {},
                                                            ))
                                                        : productScreenController
                                                                .citySelect
                                                                .isNotEmpty
                                                            ? Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: h *
                                                                            0.011),
                                                                child:
                                                                    DropDownTextField(
                                                                  onSubmitted:
                                                                      (val) {},
                                                                  onChanged:
                                                                      (val) {},
                                                                  controller:
                                                                      productScreenController
                                                                          .nearByController,
                                                                  hintText:
                                                                      AppString
                                                                          .pickoneText,
                                                                  labelText:
                                                                      AppString
                                                                          .nearByText,
                                                                ),
                                                              )
                                                            : const SizedBox(),

                                                    SizedBox(
                                                      height: h * 0.03,
                                                    ),
                                                    AppString.priceText
                                                        .semiBoldMontserratTextStyle(
                                                            fontColor: appColor,
                                                            fontSize: 20),
                                                    const Divider(
                                                        thickness: 0.8),

                                                    /// Price -----------------
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: h * 0.02),
                                                      child: Row(
                                                        children: [
                                                          "₹ ${productScreenController.start.toStringAsFixed(2)}"
                                                              .semiBoldMontserratTextStyle(
                                                                  fontColor:
                                                                      blackColor,
                                                                  fontSize: 18),
                                                          const Spacer(),
                                                          "₹ ${productScreenController.end.toStringAsFixed(2)}"
                                                              .semiBoldMontserratTextStyle(
                                                                  fontColor:
                                                                      blackColor,
                                                                  fontSize: 18),
                                                        ],
                                                      ),
                                                    ),
                                                    RangeSlider(
                                                      values: RangeValues(
                                                          productScreenController
                                                              .start,
                                                          productScreenController
                                                              .end),
                                                      labels: RangeLabels(
                                                          productScreenController
                                                              .start
                                                              .toString(),
                                                          productScreenController
                                                              .end
                                                              .toString()),
                                                      onChanged: (value) {
                                                        setState1(() {
                                                          productScreenController
                                                                  .start =
                                                              value.start;
                                                          productScreenController
                                                              .end = value.end;
                                                        });
                                                      },
                                                      min: 1.00,
                                                      max: 1000000.00,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  h * 0.03),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                AppFilledButton(
                                                                    width: w *
                                                                        0.45,
                                                                    buttonColor:
                                                                        appColor,
                                                                    onPressed:
                                                                        () async {
                                                                      controller
                                                                          .searchController
                                                                          .clear();
                                                                      productScreenController
                                                                          .clearData();

                                                                      controller
                                                                          .resetFilter();
                                                                    },
                                                                    title: AppString
                                                                        .resetText,
                                                                    radius: 10,
                                                                    textColor:
                                                                        whiteColor),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Expanded(
                                                            child:
                                                                AppFilledButton(
                                                              width: w * 0.45,
                                                              buttonColor:
                                                                  appColor,
                                                              onPressed: () {
                                                                controller
                                                                    .setCommercialServicesFilter();
                                                                Get.back();
                                                              },
                                                              title: AppString
                                                                  .applyText,
                                                              radius: 10,
                                                              textColor:
                                                                  whiteColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: h * 0.06,
                                width: h * 0.06,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Icon(
                                  Icons.filter_alt_outlined,
                                  color: appColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    (h * 0.018).addHSpace(),
                    Expanded(
                      child: controller.isLoading.value
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: h * 0.15,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white),
                                      height: h * 0.15,
                                    ),
                                  ),
                                );
                              },
                            )
                          : controller.commercialServicesFilterData.isEmpty
                              ? Center(
                                  child: AppString.dataFoundText
                                      .semiBoldMontserratTextStyle(
                                          fontColor: appColor, fontSize: 17))
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller
                                      .commercialServicesFilterData.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            Routes
                                                .commercialServicesDetailsScreen,
                                            arguments: controller
                                                    .commercialServicesFilterData[
                                                index]);
                                      },
                                      child: Container(
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: EdgeInsets.all(h * 0.01),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: greyColor)),
                                        child: Stack(
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: cachedNetworkImage(
                                                      url: controller
                                                              .commercialServicesFilterData[
                                                                  index]
                                                              .commercialServiceImagesList!
                                                              .isNotEmpty
                                                          ? '${controller.commercialServicesFilterData[index].commercialServiceImagesList?[0].imageUrl}'
                                                          : '',
                                                      height: h * 0.13,
                                                      width: h * 0.13),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: w * 0.023),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: h *
                                                                      0.005),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: '${controller.commercialServicesFilterData[index].title}'.boldMontserratTextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    textOverflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLine: 2),
                                                              ),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  controller
                                                                      .addFavouriteData(
                                                                          index);

                                                                  Map<String,
                                                                          dynamic>
                                                                      wishListData =
                                                                      {
                                                                    "id": 0,
                                                                    "productId": controller
                                                                        .commercialServicesFilterData[
                                                                            index]
                                                                        .tableRefGuid,
                                                                    "categoryId": controller
                                                                        .commercialServicesFilterData[
                                                                            index]
                                                                        .categoryId,
                                                                    "createdBy":
                                                                        preferences
                                                                            .getInt(SharedPreference.userId),
                                                                    "createdOn": DateFormat(
                                                                            "yyyy-MM-dd'T'HH:mm:ss'Z'")
                                                                        .format(
                                                                            DateTime.now()),
                                                                  };
                                                                  // controller.likedData.contains(
                                                                  //             index) ==
                                                                  //         true
                                                                  //     ?

                                                                  await myWishListController
                                                                      .addWishListData(
                                                                          wishListData:
                                                                              wishListData);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      h * 0.045,
                                                                  width:
                                                                      h * 0.045,
                                                                  decoration: const BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color:
                                                                                Colors.grey,
                                                                            blurRadius: 2)
                                                                      ],
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color:
                                                                          appColor),
                                                                  child: controller
                                                                          .likedData
                                                                          .contains(
                                                                              index)
                                                                      ? const Icon(
                                                                          Icons
                                                                              .favorite,
                                                                          color:
                                                                              secondaryAppColor,
                                                                        )
                                                                      : const Icon(
                                                                          Icons
                                                                              .favorite_border,
                                                                          color:
                                                                              whiteColor,
                                                                        ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        '₹ ${controller.commercialServicesFilterData[index].price}'
                                                            .semiBoldMontserratTextStyle(
                                                                fontSize: 18),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                CupertinoIcons
                                                                    .location_solid,
                                                                color:
                                                                    blackColor,
                                                                size: 15),
                                                            Builder(builder:
                                                                (context) {
                                                              final stateName =
                                                                  stateAbbreviation(controller
                                                                      .commercialServicesFilterData[
                                                                          index]
                                                                      .state
                                                                      .toString());
                                                              return Expanded(
                                                                child: "${controller.commercialServicesFilterData[index].nearBy} ${'${controller.commercialServicesFilterData[index].city}'}($stateName)".semiBoldMontserratTextStyle(
                                                                    maxLine: 3,
                                                                    textOverflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontColor:
                                                                        blackColor,
                                                                    fontSize:
                                                                        12),
                                                              );
                                                            }),
                                                          ],
                                                        ),
                                                        (h * 0.006).addHSpace(),
                                                        Row(
                                                          children: [
                                                            AppString
                                                                .postingDate
                                                                .regularMontserratTextStyle(
                                                                    fontSize:
                                                                        10),
                                                            "  :  ${DateFormat('dd/MM/yyyy').format(DateTime.parse('${controller.commercialServicesFilterData[index].createdOn}'))}"
                                                                .semiBoldMontserratTextStyle(
                                                                    fontSize:
                                                                        10)
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            controller
                                                        .commercialServicesFilterData[
                                                            index]
                                                        .isPremium ==
                                                    true
                                                ? Positioned(
                                                    left: w * 0.098,
                                                    top: h * 0.046,
                                                    child: const Banner(
                                                      color: blueAccentColor,
                                                      message:
                                                          AppString.premiumText,
                                                      location: BannerLocation
                                                          .bottomEnd,
                                                    ),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
