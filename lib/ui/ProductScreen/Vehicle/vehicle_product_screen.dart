import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/model/sub_category_response_model.dart';
import 'package:claxified_app/ui/BottomBarScreen/Controller/add_wishlist_controller.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:claxified_app/ui/ProductScreen/Vehicle/vehicle_screen_controller.dart';
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

class VehicleProductScreen extends StatefulWidget {
  const VehicleProductScreen({
    super.key,
  });

  @override
  State<VehicleProductScreen> createState() => _VehicleProductScreenState();
}

class _VehicleProductScreenState extends State<VehicleProductScreen> {
  MyWishListController myWishListController = Get.put(MyWishListController());
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());
  GetVehicleController controller = Get.put(GetVehicleController());

  SubCategoryResponseModel? selectedData;

  Future getData() async {
    await controller.getAllVehicleData(Get.arguments?.id);
    if (selectedData?.subCategoryName == "Cars") {
      await controller.getCarBrandsData();
    } else if (selectedData?.subCategoryName == "Bikes") {
      await controller.getBikeBrandsData();
    } else if (selectedData?.subCategoryName == "Scooty") {
      await controller.getScootyBrandsData();
    } else {
      await controller.getBicycleBrandsData();
    }
  }

  @override
  void initState() {
    selectedData = Get.arguments;
    controller.filterFuelTypes(selectedData?.subCategoryName);
    controller.filterTransmissionTypes(selectedData?.subCategoryName);
    getData();
    productScreenController.clearData();
    super.initState();
  }

  @override
  void dispose() {
    productScreenController.getAllNearByResponseModel = [];
    productScreenController.getAllCityResponseModel = [];
    nearByController.clear();
    super.dispose();
  }

  TextEditingController nearByController = TextEditingController();

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
            title: selectedData!.subCategoryName.toString(),
          ),
          body: GetBuilder<GetVehicleController>(
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
                                controller.setVehiclesFilter();
                                controller.update();
                              },
                            ),
                          ),
                          (w * 0.035).addWSpace(),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                /// FILTER -------------------------------------

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
                                        controller.clearController();
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

                                                    /// STATE -------------------------------------

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

                                                    /// CITY -------------------------------------
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

                                                    /// NEARBY -------------------------------------
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
                                                                      nearByController,
                                                                  hintText:
                                                                      AppString
                                                                          .pickoneText,
                                                                  labelText:
                                                                      AppString
                                                                          .nearByText,
                                                                ),
                                                              )
                                                            : const SizedBox(),

                                                    /// Brand -----------------

                                                    selectedData
                                                                    ?.subCategoryName
                                                                    .toString() ==
                                                                "Cars" ||
                                                            selectedData
                                                                    ?.subCategoryName
                                                                    .toString() ==
                                                                "Bikes" ||
                                                            selectedData
                                                                    ?.subCategoryName
                                                                    .toString() ==
                                                                "Scooty" ||
                                                            selectedData
                                                                    ?.subCategoryName
                                                                    .toString() ==
                                                                "Bicycle"
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: h *
                                                                        0.015),
                                                            child:
                                                                AutoCorrectField(
                                                              initialValue:
                                                                  TextEditingValue(
                                                                text: controller
                                                                    .brandSelect,
                                                              ),
                                                              suffixIcon:
                                                                  const SizedBox(),
                                                              optionList: selectedData
                                                                          ?.subCategoryName
                                                                          .toString() ==
                                                                      "Cars"
                                                                  ? controller
                                                                      .carBrandList
                                                                  : selectedData
                                                                              ?.subCategoryName ==
                                                                          "Bikes"
                                                                      ? controller
                                                                          .bikeBrandList
                                                                      : selectedData?.subCategoryName ==
                                                                              "Scooty"
                                                                          ? controller
                                                                              .scootyBrandList
                                                                          : controller
                                                                              .bicycleBrandList,
                                                              label: AppString
                                                                  .brandText,
                                                              onSelected:
                                                                  (selection) async {
                                                                controller
                                                                        .brandSelect =
                                                                    selection;

                                                                await controller.getBrandId(
                                                                    category:
                                                                        selectedData?.subCategoryName ??
                                                                            '',
                                                                    value:
                                                                        selection);

                                                                controller
                                                                    .update();
                                                              },
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                    SizedBox(
                                                      height: h * 0.02,
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
                                                          controller.update();
                                                          productScreenController
                                                              .update();
                                                        });
                                                      },
                                                      min: 1.00,
                                                      max: 1000000.0,
                                                    ),

                                                    selectedData
                                                                    ?.subCategoryName
                                                                    .toString() ==
                                                                "Cars" ||
                                                            selectedData
                                                                    ?.subCategoryName
                                                                    .toString() ==
                                                                "Bikes" ||
                                                            selectedData
                                                                    ?.subCategoryName
                                                                    .toString() ==
                                                                "Scooty" ||
                                                            selectedData
                                                                    ?.subCategoryName
                                                                    .toString() ==
                                                                "Bicycle"
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                                AppString
                                                                    .yearText
                                                                    .semiBoldMontserratTextStyle(
                                                                        fontColor:
                                                                            appColor,
                                                                        fontSize:
                                                                            20),
                                                                const Divider(
                                                                    thickness:
                                                                        0.8),

                                                                /// YEAR -------------------------------------
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child: AppSearchBar
                                                                          .formTextField(
                                                                        textInputType:
                                                                            TextInputType.number,
                                                                        hintText:
                                                                            AppString.enterFromText,
                                                                        labelText: AppString
                                                                            .formText
                                                                            .semiBoldMontserratTextStyle(fontColor: blackColor),
                                                                        controller:
                                                                            controller.yearsFromController,
                                                                      ),
                                                                    ),
                                                                    (w * 0.03)
                                                                        .addWSpace(),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child: AppSearchBar
                                                                          .formTextField(
                                                                        textInputType:
                                                                            TextInputType.number,
                                                                        hintText:
                                                                            AppString.enterToText,
                                                                        labelText: AppString
                                                                            .toText
                                                                            .semiBoldMontserratTextStyle(fontColor: blackColor),
                                                                        controller:
                                                                            controller.yearsToController,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                if (selectedData
                                                                        ?.subCategoryName !=
                                                                    "Bicycle") ...[
                                                                  (h * 0.02)
                                                                      .addHSpace(),
                                                                  AppString.kmDrivenText.semiBoldMontserratTextStyle(
                                                                      fontColor:
                                                                          appColor,
                                                                      fontSize:
                                                                          20),
                                                                  const Divider(
                                                                      thickness:
                                                                          0.8),

                                                                  /// KM DRIVEN -----------------
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: h *
                                                                            0.02),
                                                                    child: Row(
                                                                      children: [
                                                                        "₹ ${controller.kmStart.toStringAsFixed(2)}".semiBoldMontserratTextStyle(
                                                                            fontColor:
                                                                                blackColor,
                                                                            fontSize:
                                                                                18),
                                                                        const Spacer(),
                                                                        "₹ ${controller.kmEnd.toStringAsFixed(2)}".semiBoldMontserratTextStyle(
                                                                            fontColor:
                                                                                blackColor,
                                                                            fontSize:
                                                                                18),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  RangeSlider(
                                                                    values: RangeValues(
                                                                        controller
                                                                            .kmStart,
                                                                        controller
                                                                            .kmEnd),
                                                                    labels: RangeLabels(
                                                                        controller
                                                                            .kmStart
                                                                            .toString(),
                                                                        controller
                                                                            .kmEnd
                                                                            .toString()),
                                                                    onChanged:
                                                                        (value) {
                                                                      setState1(
                                                                          () {
                                                                        controller.kmStart =
                                                                            value.start;
                                                                        controller.kmEnd =
                                                                            value.end;
                                                                      });
                                                                    },
                                                                    min: 0.0,
                                                                    max:
                                                                        100000.0,
                                                                  ),

                                                                  /// No of owners ------------------------------------
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: h *
                                                                            0.015),
                                                                    child:
                                                                        AutoCorrectField(
                                                                      initialValue:
                                                                          TextEditingValue(
                                                                        text: controller
                                                                            .selectOwnerCount,
                                                                      ),
                                                                      suffixIcon:
                                                                          const SizedBox(),
                                                                      optionList:
                                                                          controller
                                                                              .noOfOwner,
                                                                      label: AppString
                                                                          .noOwnerText,
                                                                      onSelected:
                                                                          (selection) async {
                                                                        controller.selectOwnerCount =
                                                                            selection;
                                                                        controller
                                                                            .update();
                                                                      },
                                                                    ),
                                                                  ),

                                                                  /// FUEL TYPE ------------------------------------
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: h *
                                                                            0.015),
                                                                    child:
                                                                        AutoCorrectField(
                                                                      initialValue:
                                                                          TextEditingValue(
                                                                        text: controller
                                                                            .selectFuelType,
                                                                      ),
                                                                      suffixIcon:
                                                                          const SizedBox(),
                                                                      optionList:
                                                                          controller
                                                                              .filteredFuelTypeList,
                                                                      label: AppString
                                                                          .vehicleTypeText,
                                                                      onSelected:
                                                                          (selection) async {
                                                                        controller.selectFuelType =
                                                                            selection;
                                                                        await controller
                                                                            .getFuelID(selection);
                                                                        controller
                                                                            .update();
                                                                      },
                                                                    ),
                                                                  ),

                                                                  /// TRANSMISSION TYPE ------------------------------------
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        top: h *
                                                                            0.015),
                                                                    child:
                                                                        AutoCorrectField(
                                                                      initialValue:
                                                                          TextEditingValue(
                                                                        text: controller
                                                                            .selectTransmissionType,
                                                                      ),
                                                                      suffixIcon:
                                                                          const SizedBox(),
                                                                      optionList:
                                                                          controller
                                                                              .filteredTransmissionList,
                                                                      label: AppString
                                                                          .transmissionTypeText,
                                                                      onSelected:
                                                                          (selection) async {
                                                                        controller.selectTransmissionType =
                                                                            selection;
                                                                        await controller
                                                                            .getTransmissionID(selection);
                                                                        controller
                                                                            .update();
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ])
                                                        : const SizedBox(),

                                                    SizedBox(
                                                      height: h * 0.2,
                                                    ),

                                                    /// RESET & APPLY BUTTON ------------------------------------
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  h * 0.02),
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
                                                                          .clearController();
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
                                                                    .setVehiclesFilter();
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

                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom,
                                                    )
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
                      child: controller.isLoading.value == true
                          ? ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: 10,
                              shrinkWrap: true,
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
                          : controller.vehicleFilterData.isEmpty
                              ? Center(
                                  child: AppString.dataFoundText
                                      .semiBoldMontserratTextStyle(
                                          fontColor: appColor, fontSize: 17))
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.vehicleFilterData.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.vehicleDetailsScreen,
                                            arguments: controller
                                                .vehicleFilterData[index]);
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
                                                        BorderRadius.circular(
                                                            10),
                                                    child: cachedNetworkImage(
                                                      url: controller
                                                              .vehicleFilterData[
                                                                  index]
                                                              .vehicleImageList!
                                                              .isNotEmpty
                                                          ? '${controller.vehicleFilterData[index].vehicleImageList?[0].imageUrl}'
                                                          : '',
                                                      height: h * 0.13,
                                                      width: h * 0.13,
                                                    )),
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
                                                                child: '${controller.vehicleFilterData[index].title}'.boldMontserratTextStyle(
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
                                                                        .vehicleFilterData[
                                                                            index]
                                                                        .tableRefGuid,
                                                                    "categoryId": controller
                                                                        .vehicleFilterData[
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
                                                        '₹ ${controller.vehicleFilterData[index].price}'
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
                                                                      .vehicleFilterData[
                                                                          index]
                                                                      .state
                                                                      .toString());
                                                              return Expanded(
                                                                child: "${controller.vehicleFilterData[index].nearBy} ${'${controller.vehicleFilterData[index].city}'}($stateName)".semiBoldMontserratTextStyle(
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
                                                            "  :  ${DateFormat('dd/MM/yyyy').format(DateTime.parse('${controller.vehicleFilterData[index].createdOn}'))}"
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
                                            controller.vehicleFilterData[index]
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
