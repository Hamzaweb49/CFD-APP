import 'package:claxified_app/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer {
  /// CATEGORY SHIMMER

  static Widget categoryShimmer(double h, double w) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          width: h * 0.115,
          height: h * 0.115,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          margin: EdgeInsets.symmetric(horizontal: w * 0.015),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              width: h * 0.115,
              height: h * 0.115,
            ),
          ),
        );
      },
    );
  }

  /// PRODUCT DATA SHIMMER

  static Widget productDataShimmer(double w, double h) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.016)
          .copyWith(bottom: h * 0.035),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: w * 0.032,
          childAspectRatio: h * 0.00083,
          mainAxisSpacing: h * 0.02,
          crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: whiteColor),
          ),
        );
      },
    );
  }
}
