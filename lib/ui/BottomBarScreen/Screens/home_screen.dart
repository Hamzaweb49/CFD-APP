import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/ui/BottomBarScreen/Controller/add_wishlist_controller.dart';
import 'package:claxified_app/ui/BottomBarScreen/Controller/bottom_bar_controller.dart';
import 'package:claxified_app/ui/BottomBarScreen/Screens/ProfileScreen/Controller/profile_screen_controller.dart';
import 'package:claxified_app/ui/ProductScreen/Controller/product_screen_controller.dart';
import 'package:claxified_app/utils/app_routes.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:claxified_app/widgets/app_shimmer.dart';
import 'package:claxified_app/widgets/app_text_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductScreenController productScreenController =
      Get.put(ProductScreenController());
  BottomNavBarController bottomNavBarController =
      Get.put(BottomNavBarController());

  MyWishListController myWishListController = Get.put(MyWishListController());

  ProfileScreenController profileScreenController =
      Get.put(ProfileScreenController());

  Future<void> getData() async {
    await bottomNavBarController.getAllCategory();
    await bottomNavBarController.getAllDashboardDataController();
    await productScreenController.getStateData();
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
          body: GetBuilder<BottomNavBarController>(
            builder: (controller) {
              return Column(
                children: [
                  Container(
                    height: h * 0.05,
                    color: appColor.withOpacity(0.7),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.locationScreen,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.02),
                              child: const Icon(CupertinoIcons.location_solid,
                                  color: secondaryAppColor),
                            ),
                            "Set Location".semiBoldMontserratTextStyle(
                              fontColor: whiteColor,
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: whiteColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * 0.025),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: h * 0.016),
                              child: const AppSearchBar(
                                hintText: AppString.search,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * 0.002),
                              child: Row(
                                children: [
                                  AppString.categoriesText
                                      .boldMontserratTextStyle(
                                          fontColor: appColor),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                          Routes.selectCategoryScreenList);
                                    },
                                    child: AppString.seeAllText
                                        .boldMontserratTextStyle(
                                            textDecoration:
                                                TextDecoration.underline,
                                            fontColor: appColor),
                                  ),
                                ],
                              ),
                            ),
                            (h * 0.013).addHSpace(),
                            SizedBox(
                              height: h * 0.118,
                              child: controller.dashboardLoading.value
                                  ? AppShimmer.categoryShimmer(h, w)
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller
                                          .getAllCategoryResponseModel?.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.updateData(index);
                                            Get.toNamed(
                                              Routes.selectSubCategoriesScreen,
                                              arguments: {
                                                "select": controller
                                                        .getAllCategoryResponseModel?[
                                                    index],
                                                "screen": 'HomeScreen',
                                              },
                                            );
                                          },
                                          child: Container(
                                            width: h * 0.115,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: w * 0.015),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: controller.select == index
                                                  ? appColor
                                                  : Colors.grey.shade300,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                (h * 0.014).addHSpace(),
                                                Expanded(
                                                    flex: 2,
                                                    child: assetImage(
                                                      selectCategoryImage[
                                                          index],
                                                      scale: 15,
                                                    )),
                                                Expanded(
                                                  flex: 2,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.004),
                                                    child: controller
                                                        .getAllCategoryResponseModel?[
                                                            index]
                                                        .categoryName
                                                        .toString()
                                                        .semiBoldMontserratTextStyle(
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLine: 2,
                                                          textOverflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          fontSize: h * 0.015,
                                                          fontColor: controller
                                                                      .select ==
                                                                  index
                                                              ? whiteColor
                                                              : blackColor,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),
                            (h * 0.0025).addHSpace(),
                            controller.dashboardLoading.value
                                ? AppShimmer.productDataShimmer(w, h)
                                : GridView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(
                                            horizontal: w * 0.02,
                                            vertical: h * 0.016)
                                        .copyWith(bottom: h * 0.035),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller
                                        .getAllDashboardDataResponseModel
                                        .length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisSpacing: w * 0.032,
                                            childAspectRatio: h * 0.00076,
                                            mainAxisSpacing: h * 0.02,
                                            crossAxisCount: 2),
                                    itemBuilder: (context, index) {
                                      String formattedTime = DateFormat.yMd()
                                          .format(controller
                                              .getAllDashboardDataResponseModel[
                                                  index]
                                              .createdOn!);
                                      final stateCode = stateAbbreviation(
                                          '${controller.getAllDashboardDataResponseModel[index].state}');
                                      return GestureDetector(
                                        onTap: () {
                                          profileScreenController
                                              .openDashBoardDetailsScreen(controller
                                                      .getAllDashboardDataResponseModel[
                                                  index]);
                                          controller.update();
                                        },
                                        child: Container(
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            color: whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: greyColor,
                                                blurRadius: 1,
                                              )
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: h * 0.008),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    (h * 0.012).addHSpace(),
                                                    Stack(
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        SizedBox(
                                                          height: h * 0.182,
                                                          width: h * 0.2,
                                                          child: Center(
                                                            child:
                                                                cachedNetworkImage(
                                                              url: controller
                                                                      .getAllDashboardDataResponseModel[
                                                                          index]
                                                                      .productImage?[
                                                                          0]
                                                                      .imageUrl ??
                                                                  '',
                                                              height: h * 0.181,
                                                              width: h * 0.197,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            controller
                                                                        .getAllDashboardDataResponseModel[
                                                                            index]
                                                                        .isPremium ==
                                                                    true
                                                                ? Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: w *
                                                                            0.106,
                                                                        top: h *
                                                                            0.045),
                                                                    child:
                                                                        const Banner(
                                                                      color:
                                                                          blueAccentColor,
                                                                      message:
                                                                          AppString
                                                                              .premiumText,
                                                                      location:
                                                                          BannerLocation
                                                                              .bottomEnd,
                                                                    ),
                                                                  )
                                                                : const SizedBox(),
                                                            const Spacer(),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: h *
                                                                          0.004,
                                                                      right: w *
                                                                          0.008),
                                                              child:
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
                                                                    "id": controller
                                                                        .getAllDashboardDataResponseModel[
                                                                            index]
                                                                        .id,
                                                                    "productId": controller
                                                                        .getAllDashboardDataResponseModel[
                                                                            index]
                                                                        .tableRefGuid,
                                                                    "categoryId": controller
                                                                        .getAllDashboardDataResponseModel[
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
                                                                  await myWishListController
                                                                      .addWishListData(
                                                                          wishListData:
                                                                              wishListData);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      h * 0.047,
                                                                  width:
                                                                      h * 0.047,
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.8),
                                                                            blurRadius: 1)
                                                                      ],
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color:
                                                                          appColor),
                                                                  child: Center(
                                                                    child: controller
                                                                            .likedData
                                                                            .contains(index)
                                                                        ? const Icon(
                                                                            Icons.favorite,
                                                                            color:
                                                                                secondaryAppColor,
                                                                          )
                                                                        : const Icon(
                                                                            Icons.favorite_border,
                                                                            color:
                                                                                whiteColor,
                                                                          ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Positioned(
                                                          bottom: h * 0.00,
                                                          child: Container(
                                                            height: h * 0.038,
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        w * 0.01),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                color: blackColor
                                                                    .withOpacity(
                                                                        0.8)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .camera_alt_outlined,
                                                                  size: 20,
                                                                  color:
                                                                      whiteColor,
                                                                ),
                                                                (w * 0.007)
                                                                    .addWSpace(),
                                                                "${controller.getAllDashboardDataResponseModel[index].productImage?.length}"
                                                                    .boldMontserratTextStyle(
                                                                        fontColor:
                                                                            whiteColor)
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      // height: h * 0.09,
                                                      margin: EdgeInsets.only(
                                                          top: h * 0.008),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            "₹ ${controller.getAllDashboardDataResponseModel[index].price}"
                                                                .boldMontserratTextStyle(),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical: h *
                                                                          0.006),
                                                              child: formattedTime
                                                                  .semiBoldMontserratTextStyle(
                                                                      fontSize:
                                                                          10),
                                                            ),
                                                            '${controller.getAllDashboardDataResponseModel[index].title}'
                                                                .regularMontserratTextStyle(
                                                                    maxLine: 2,
                                                                    fontSize:
                                                                        12,
                                                                    textOverflow:
                                                                        TextOverflow
                                                                            .ellipsis),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.all(h * 0.0077),
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight: Radius
                                                              .circular(5),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  5)),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Icon(
                                                          CupertinoIcons
                                                              .location_solid,
                                                          color: blackColor,
                                                          size: 15),
                                                      Expanded(
                                                        child: "${controller.getAllDashboardDataResponseModel[index].nearBy} ${controller.getAllDashboardDataResponseModel[index].city}($stateCode)"
                                                            .semiBoldMontserratTextStyle(
                                                                fontColor:
                                                                    blackColor,
                                                                maxLine: 1,
                                                                textOverflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontSize: 11),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
