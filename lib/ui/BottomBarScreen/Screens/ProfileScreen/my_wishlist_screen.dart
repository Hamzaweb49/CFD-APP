import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/ui/BottomBarScreen/Screens/ProfileScreen/Controller/profile_screen_controller.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyWishListScreen extends StatefulWidget {
  const MyWishListScreen({super.key});

  @override
  State<MyWishListScreen> createState() => _MyWishListScreen();
}

class _MyWishListScreen extends State<MyWishListScreen> {
  ProfileScreenController profileScreenController =
      Get.put(ProfileScreenController());

  Future getData() async {
    profileScreenController.getDashBoardByGuidData();
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
            title: AppString.myWishlistText,
          ),
          body: GetBuilder<ProfileScreenController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 0.04, vertical: h * 0.016),
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.wishListData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: w * 0.032,
                          childAspectRatio: h * 0.00079,
                          mainAxisSpacing: h * 0.02,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final stateCode = stateAbbreviation(
                            '${controller.wishListData[index].state}');
                        return GestureDetector(
                          onTap: () {
                            profileScreenController.openWishListDetailsScreen(
                                controller.wishListData[index]);
                            controller.update();
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: whiteColor,
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
                                        children: [
                                          SizedBox(
                                            height: h * 0.182,
                                            width: h * 0.2,
                                            child: Center(
                                              child: cachedNetworkImage(
                                                url: controller
                                                    .wishListImage(index),
                                                height: h * 0.181,
                                                width: h * 0.197,
                                              ),
                                            ),
                                          ),
                                          controller.wishListData[index]
                                                      .isPremium ==
                                                  true
                                              ? Positioned(
                                                  left: w * 0.106,
                                                  top: h * 0.045,
                                                  child: const Banner(
                                                    color: blueAccentColor,
                                                    message:
                                                        AppString.premiumText,
                                                    location: BannerLocation
                                                        .bottomEnd,
                                                  ),
                                                )
                                              : const SizedBox(),
                                          Positioned(
                                            bottom: h * 0.0,
                                            child: Container(
                                              height: h * 0.038,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: w * 0.01),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: blackColor
                                                      .withOpacity(0.8)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.camera_alt_outlined,
                                                    size: 20,
                                                    color: whiteColor,
                                                  ),
                                                  (w * 0.007).addWSpace(),
                                                  controller.imageLength
                                                      .boldMontserratTextStyle(
                                                          fontColor: whiteColor)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: h * 0.008),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              controller.wishListData[index]
                                                      .jobImageList.isNotEmpty
                                                  ? const SizedBox()
                                                  : "₹ ${controller.wishListData[index].price ?? ""}"
                                                      .boldMontserratTextStyle(),
                                              controller.wishListData[index]
                                                      .jobImageList.isNotEmpty
                                                  ? const SizedBox()
                                                  : Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  h * 0.006),
                                                      child: DateFormat(
                                                              'dd/MM/yyyy')
                                                          .format(DateTime
                                                              .parse(controller
                                                                      .wishListData[
                                                                          index]
                                                                      .createdOn ??
                                                                  ""))
                                                          .semiBoldMontserratTextStyle(
                                                              fontSize: 10),
                                                    ),
                                              '${controller.wishListData[index].title ?? ""}'
                                                  .regularMontserratTextStyle(
                                                      maxLine: 2,
                                                      fontSize: 12,
                                                      textOverflow: TextOverflow
                                                          .ellipsis),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(h * 0.0077),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(5)),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                            CupertinoIcons.location_solid,
                                            color: blackColor,
                                            size: 15),
                                        Expanded(
                                          child:
                                              "${controller.wishListData[index].nearBy ?? ""} ${controller.wishListData[index].city ?? ""}($stateCode)"
                                                  .semiBoldMontserratTextStyle(
                                                      fontColor: blackColor,
                                                      maxLine: 1,
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 11),
                                        )
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
