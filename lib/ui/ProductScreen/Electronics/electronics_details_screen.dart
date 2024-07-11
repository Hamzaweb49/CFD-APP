import 'package:carousel_slider/carousel_slider.dart';
import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/constant/app_string.dart';
import 'package:claxified_app/model/product_list_model/get_all_electronics_response_model.dart';
import 'package:claxified_app/ui/BottomBarScreen/Controller/add_wishlist_controller.dart';
import 'package:claxified_app/ui/ProductScreen/Electronics/electronics_screen_controller.dart';
import 'package:claxified_app/utils/extension.dart';
import 'package:claxified_app/utils/shared_prefs.dart';
import 'package:claxified_app/widgets/app_appbar.dart';
import 'package:claxified_app/widgets/app_button.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ElectronicsDetailsScreen extends StatefulWidget {
  const ElectronicsDetailsScreen({super.key});

  @override
  State<ElectronicsDetailsScreen> createState() =>
      _ElectronicsDetailsScreenState();
}

class _ElectronicsDetailsScreenState extends State<ElectronicsDetailsScreen> {
  GetElectronicsController getElectronicsController =
      Get.put(GetElectronicsController());
  GetAllElectronicsResponseModel? productData;
  MyWishListController myWishListController = Get.put(MyWishListController());

  @override
  void initState() {
    productData = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formattedTime =
        DateFormat.yMd().format(DateTime.parse(productData?.createdOn ?? ''));
    final stateCode = stateAbbreviation('${productData?.state}');
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return AppContainer(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: whiteColor,
          appBar: CommonAppBar(
            action: const Icon(
              Icons.share,
              color: whiteColor,
            ),
            h: h,
            w: w,
            title: '',
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: GetBuilder<GetElectronicsController>(
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (h * 0.02).addHSpace(),
                    CarouselSlider.builder(
                      itemCount:
                          productData?.electronicApplianceImageList?.length ??
                              1,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return cachedNetworkImage(
                            url: productData
                                    ?.electronicApplianceImageList?[index]
                                    .imageUrl ??
                                '',
                            height: h * 0.1);
                      },
                      options: CarouselOptions(
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            controller.updateData(index);
                          },
                          autoPlay: false,
                          reverse: productData
                                      ?.electronicApplianceImageList?.length ==
                                  0
                              ? true
                              : false,
                          clipBehavior: Clip.none,
                          viewportFraction: 1,
                          height: h * 0.4,
                          aspectRatio: 1,
                          pageSnapping: true),
                    ),
                    (h * 0.02).addHSpace(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                        right: 0,
                        bottom: 7,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          productData?.electronicApplianceImageList?.length ??
                              1,
                          (index) => Container(
                            height: h * 0.006,
                            width: h * 0.017,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                                color: controller.selectProductDetails == index
                                    ? appColor
                                    : Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.045),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: h * 0.02, bottom: h * 0.0011),
                                  child: "${productData?.title}"
                                      .boldMontserratTextStyle(
                                          fontSize: 18,
                                          maxLine: 5,
                                          textOverflow: TextOverflow.ellipsis),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () async {
                                    controller.selectLikeData();
                                    Map<String, dynamic> wishListData = {
                                      "id": 0,
                                      "productId": productData?.tableRefGuid,
                                      "categoryId": productData?.categoryId,
                                      "createdBy": preferences
                                          .getInt(SharedPreference.userId),
                                      "createdOn":
                                          DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'")
                                              .format(DateTime.now()),
                                    };
                                    await myWishListController.addWishListData(
                                        wishListData: wishListData);
                                  },
                                  child: Container(
                                    height: h * 0.047,
                                    width: h * 0.047,
                                    decoration: const BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey, blurRadius: 2)
                                    ], shape: BoxShape.circle, color: appColor),
                                    child: Center(
                                      child: controller.likeSelect
                                          ? const Icon(
                                              Icons.favorite,
                                              color: secondaryAppColor,
                                            )
                                          : const Icon(
                                              Icons.favorite_border,
                                              color: whiteColor,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          (h * 0.002).addHSpace(),
                          '₹ ${productData?.price}'
                              .semiBoldMontserratTextStyle(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: h * 0.011),
                            child: const Divider(thickness: 1),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: h * 0.013, horizontal: w * 0.04),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.date_range,
                                        color: appColor,
                                      ),
                                      (w * 0.02).addWSpace(),
                                      AppString.postingDate
                                          .regularMontserratTextStyle(
                                              fontSize: 15),
                                      const Spacer(),
                                      (w * 0.02).addWSpace(),
                                      formattedTime.semiBoldMontserratTextStyle(
                                          fontSize: 15)
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                    height: h * 0.035,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: appColor,
                                      ),
                                      (w * 0.02).addWSpace(),
                                      AppString.locationCap
                                          .regularMontserratTextStyle(
                                              fontSize: 15),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: w * 0.52,
                                            child: "${productData?.nearBy}"
                                                .regularMontserratTextStyle(
                                                    textAlign: TextAlign.right,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                    maxLine: 4,
                                                    fontSize: 15),
                                          ),
                                          (h * 0.003).addHSpace(),
                                          SizedBox(
                                            width: w * 0.52,
                                            child:
                                                "${productData?.city}($stateCode)"
                                                    .semiBoldMontserratTextStyle(
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                              maxLine: 4,
                                              textAlign: TextAlign.right,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: h * 0.011),
                            child: AppString.descriptions
                                .semiBoldMontserratTextStyle(fontSize: 19),
                          ),
                          "${productData?.discription}"
                              .regularMontserratTextStyle(fontSize: 15),
                          (h * 0.02).addHSpace(),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          bottomNavigationBar: BottomAppBar(
              child: Padding(
            padding: EdgeInsets.only(
                top: h * 0.009,
                left: w * 0.15,
                right: w * 0.15,
                bottom: h * 0.002),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Expanded(
                //   flex: 1,
                //   child: AppFilledButton(
                //     radius: 6,
                //     onPressed: () {},
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         const Icon(
                //           CupertinoIcons.chat_bubble,
                //           color: whiteColor,
                //           size: 22,
                //         ),
                //         Padding(
                //           padding: EdgeInsets.only(left: w * 0.019),
                //           child: AppString.chatText.semiBoldMontserratTextStyle(
                //               fontColor: whiteColor, fontSize: 17),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // (w * 0.035).addWSpace(),
                Expanded(
                  flex: 1,
                  child: AppFilledButton(
                    radius: 6,
                    onPressed: () async {
                      String phoneNumber = '+91${productData?.mobile ?? ''}';
                      final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        throw 'Could not launch ${uri.toString()}';
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.call,
                          size: 22,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.019),
                          child: AppString.callText.semiBoldMontserratTextStyle(
                              fontColor: whiteColor, fontSize: 17),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
