import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'Controller/profile_screen_controller.dart';

class ManageAdsScreen extends StatefulWidget {
  const ManageAdsScreen({super.key});

  @override
  State<ManageAdsScreen> createState() => _ManageAdsScreenState();
}

class _ManageAdsScreenState extends State<ManageAdsScreen>
    with TickerProviderStateMixin {
  ProfileScreenController adsScreenController =
      Get.put(ProfileScreenController());

  Future<void> getData() async {
    await adsScreenController.getAllCategory();
    await adsScreenController
        .getAllAdsData(preferences.getInt(SharedPreference.userId).toString());
  }

  TabController? tabController;

  @override
  void initState() {
    getData();
    tabController = TabController(
      initialIndex: 0,
      length: 3,
      vsync: this,
    );
    adsScreenController.clearData();
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
            title: AppString.adsText,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.040),
            child: GetBuilder<ProfileScreenController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (h * 0.02).addHSpace(),
                    TabBar(
                      controller: tabController,
                      onTap: (value) {
                        controller.selected = value;
                        controller.update();
                      },
                      indicatorColor: appColor,
                      tabs: [
                        Tab(
                          icon:
                              AppString.activeText.semiBoldMontserratTextStyle(
                            fontColor:
                                controller.selected == 0 ? appColor : greyColor,
                          ),
                        ),
                        Tab(
                          icon: AppString.inActiveText
                              .semiBoldMontserratTextStyle(
                            fontColor:
                                controller.selected == 1 ? appColor : greyColor,
                          ),
                        ),
                        Tab(
                          icon:
                              AppString.pendingText.semiBoldMontserratTextStyle(
                            fontColor:
                                controller.selected == 2 ? appColor : greyColor,
                          ),
                        ),
                      ],
                    ),
                    (h * 0.02).addHSpace(),
                    controller.selected == 0
                        ? active(controller: controller)
                        : controller.selected == 1
                            ? inActive(controller: controller)
                            : controller.isLoading.value == true
                                ? const Expanded(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : pending(controller: controller)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget active({required ProfileScreenController controller}) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppString.pendingAdsText.semiBoldMontserratTextStyle(fontSize: 20),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.getAllAdsResponseModel.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => controller
                              .getAllAdsResponseModel[index].isActive ==
                          true &&
                      controller.getAllAdsResponseModel[index].isVerified ==
                          true
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: h * 0.011),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: greyColor.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.openAdsDetailsScreen(
                                  controller.getAllAdsResponseModel[index]);
                              controller.update();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.02),
                                  child: Container(
                                    height: h * 0.12,
                                    width: h * 0.12,
                                    margin: EdgeInsets.symmetric(
                                        vertical: h * 0.011),
                                    decoration: BoxDecoration(
                                      color: greyColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: cachedNetworkImage(
                                        url: controller.manageAdsImage(index),
                                        height: h * 0.13,
                                        width: h * 0.13,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: w * 0.025, top: h * 0.011),
                                  child: SizedBox(
                                    width: w * 0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        "${controller.getAllAdsResponseModel[index].title.toString().capitalizeFirst}"
                                            .semiBoldMontserratTextStyle(
                                                maxLine: 2,
                                                fontSize: 17,
                                                textOverflow:
                                                    TextOverflow.ellipsis),
                                        (h * 0.0045).addHSpace(),
                                        DateFormat('dd/MM/yyyy')
                                            .format(DateTime.parse(
                                                '${controller.getAllAdsResponseModel[index].createdOn}'))
                                            .w500MontserratTextStyle(
                                                fontSize: 14),
                                        (h * 0.0012).addHSpace(),
                                        "₹ ${controller.getAllAdsResponseModel[index].price}"
                                            .w500MontserratTextStyle(
                                                fontSize: 14),
                                        (h * 0.0025).addHSpace(),
                                        "${controller.getAllAdsResponseModel[index].discription}"
                                            .w500MontserratTextStyle(
                                                fontSize: 14,
                                                maxLine: 2,
                                                textOverflow:
                                                    TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        onTap: () {
                                          controller.openForm(
                                            controller
                                                .getAllAdsResponseModel[index],
                                          );
                                        },
                                        child: AppString.editText
                                            .w500MontserratTextStyle(),
                                      ),
                                      PopupMenuItem(
                                        onTap: () async {
                                          await controller.deleteForm(
                                            controller
                                                .getAllAdsResponseModel[index],
                                          );
                                          await adsScreenController
                                              .getAllAdsData(preferences
                                                  .getInt(
                                                      SharedPreference.userId)
                                                  .toString());
                                        },
                                        child: AppString.deleteText
                                            .w500MontserratTextStyle(),
                                      )
                                    ];
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 0.02, vertical: h * 0.008),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.remove_red_eye,
                                  size: h * 0.024,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.012),
                                  child: AppString.viewText
                                      .semiBoldMontserratTextStyle(
                                          fontSize: 12),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.015),
                                  child: Icon(
                                    Icons.favorite,
                                    size: h * 0.024,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.012),
                                  child: AppString.likesText
                                      .semiBoldMontserratTextStyle(
                                          fontSize: 12),
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: h * 0.018,
                                      vertical: h * 0.014),
                                  decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      AppString.publishedText,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: h * 0.015,
                                      vertical: h * 0.015),
                                  margin: const EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  child: const Center(
                                    child: Text(
                                      AppString.postNowText,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }

  Widget inActive({required ProfileScreenController controller}) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppString.pendingAdsText.semiBoldMontserratTextStyle(fontSize: 20),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.getAllAdsResponseModel.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => controller
                              .getAllAdsResponseModel[index].isActive ==
                          false &&
                      controller.getAllAdsResponseModel[index].isVerified ==
                          true
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: h * 0.011),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: greyColor.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.openAdsDetailsScreen(
                                  controller.getAllAdsResponseModel[index]);
                              controller.update();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.02),
                                  child: Container(
                                    height: h * 0.12,
                                    width: h * 0.12,
                                    margin: EdgeInsets.symmetric(
                                        vertical: h * 0.011),
                                    decoration: BoxDecoration(
                                      color: greyColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: cachedNetworkImage(
                                        url: controller.manageAdsImage(index),
                                        height: h * 0.13,
                                        width: h * 0.13,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: w * 0.025, top: h * 0.011),
                                  child: SizedBox(
                                    width: w * 0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        "${controller.getAllAdsResponseModel[index].title.toString().capitalizeFirst}"
                                            .semiBoldMontserratTextStyle(
                                                maxLine: 2,
                                                fontSize: 17,
                                                textOverflow:
                                                    TextOverflow.ellipsis),
                                        (h * 0.0045).addHSpace(),
                                        DateFormat('dd/MM/yyyy')
                                            .format(DateTime.parse(
                                                '${controller.getAllAdsResponseModel[index].createdOn}'))
                                            .w500MontserratTextStyle(
                                                fontSize: 14),
                                        (h * 0.0012).addHSpace(),
                                        "₹ ${controller.getAllAdsResponseModel[index].price}"
                                            .w500MontserratTextStyle(
                                                fontSize: 14),
                                        (h * 0.0025).addHSpace(),
                                        "${controller.getAllAdsResponseModel[index].discription}"
                                            .w500MontserratTextStyle(
                                                fontSize: 14,
                                                maxLine: 2,
                                                textOverflow:
                                                    TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        onTap: () {
                                          controller.openForm(
                                            controller
                                                .getAllAdsResponseModel[index],
                                          );
                                        },
                                        child: AppString.editText
                                            .w500MontserratTextStyle(),
                                      ),
                                      PopupMenuItem(
                                        onTap: () async {
                                          await controller.deleteForm(
                                            controller
                                                .getAllAdsResponseModel[index],
                                          );
                                          await adsScreenController
                                              .getAllAdsData(preferences
                                                  .getInt(
                                                      SharedPreference.userId)
                                                  .toString());
                                        },
                                        child: AppString.deleteText
                                            .w500MontserratTextStyle(),
                                      )
                                    ];
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 0.02, vertical: h * 0.008),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.remove_red_eye,
                                  size: h * 0.024,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.012),
                                  child: AppString.viewText
                                      .semiBoldMontserratTextStyle(
                                          fontSize: 12),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.015),
                                  child: Icon(
                                    Icons.favorite,
                                    size: h * 0.024,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.012),
                                  child: AppString.likesText
                                      .semiBoldMontserratTextStyle(
                                          fontSize: 12),
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: h * 0.018,
                                      vertical: h * 0.014),
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.orangeAccent,
                                          width: 1)),
                                  child: const Center(
                                    child: Text(
                                      AppString.pendingText,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: h * 0.015,
                                      vertical: h * 0.015),
                                  margin: const EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  child: const Center(
                                    child: Text(
                                      AppString.postNowText,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }

  Widget pending({required ProfileScreenController controller}) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppString.pendingAdsText.semiBoldMontserratTextStyle(fontSize: 20),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.getAllAdsResponseModel.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => controller
                          .getAllAdsResponseModel[index].isVerified ==
                      false
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: h * 0.011),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: greyColor.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.openAdsDetailsScreen(
                                  controller.getAllAdsResponseModel[index]);
                              controller.update();
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.02),
                                  child: Container(
                                    height: h * 0.12,
                                    width: h * 0.12,
                                    margin: EdgeInsets.symmetric(
                                        vertical: h * 0.011),
                                    decoration: BoxDecoration(
                                      color: greyColor.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: cachedNetworkImage(
                                        url: controller.manageAdsImage(index),
                                        height: h * 0.13,
                                        width: h * 0.13,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: w * 0.025, top: h * 0.011),
                                  child: SizedBox(
                                    width: w * 0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        "${controller.getAllAdsResponseModel[index].title.toString().capitalizeFirst}"
                                            .semiBoldMontserratTextStyle(
                                                maxLine: 2,
                                                fontSize: 17,
                                                textOverflow:
                                                    TextOverflow.ellipsis),
                                        (h * 0.0045).addHSpace(),
                                        DateFormat('dd/MM/yyyy')
                                            .format(DateTime.parse(
                                                '${controller.getAllAdsResponseModel[index].createdOn}'))
                                            .w500MontserratTextStyle(
                                                fontSize: 14),
                                        (h * 0.0012).addHSpace(),
                                        "₹ ${controller.getAllAdsResponseModel[index].price}"
                                            .w500MontserratTextStyle(
                                                fontSize: 14),
                                        (h * 0.0025).addHSpace(),
                                        "${controller.getAllAdsResponseModel[index].discription}"
                                            .w500MontserratTextStyle(
                                                fontSize: 14,
                                                maxLine: 2,
                                                textOverflow:
                                                    TextOverflow.ellipsis),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        onTap: () {
                                          controller.openForm(
                                            controller
                                                .getAllAdsResponseModel[index],
                                          );
                                        },
                                        child: AppString.editText
                                            .w500MontserratTextStyle(),
                                      ),
                                      PopupMenuItem(
                                        onTap: () async {
                                          await controller.deleteForm(
                                            controller
                                                .getAllAdsResponseModel[index],
                                          );
                                          await adsScreenController
                                              .getAllAdsData(preferences
                                                  .getInt(
                                                      SharedPreference.userId)
                                                  .toString());
                                        },
                                        child: AppString.deleteText
                                            .w500MontserratTextStyle(),
                                      )
                                    ];
                                  },
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: w * 0.02, vertical: h * 0.008),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.remove_red_eye,
                                  size: h * 0.024,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.012),
                                  child: AppString.viewText
                                      .semiBoldMontserratTextStyle(
                                          fontSize: 12),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.015),
                                  child: Icon(
                                    Icons.favorite,
                                    size: h * 0.024,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.012),
                                  child: AppString.likesText
                                      .semiBoldMontserratTextStyle(
                                          fontSize: 12),
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: h * 0.018,
                                      vertical: h * 0.014),
                                  decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.orangeAccent,
                                          width: 1)),
                                  child: const Center(
                                    child: Text(
                                      AppString.pendingText,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: h * 0.015,
                                      vertical: h * 0.015),
                                  margin: const EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.black, width: 1)),
                                  child: const Center(
                                    child: Text(
                                      AppString.postNowText,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
