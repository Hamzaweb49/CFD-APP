import 'package:claxified_app/constant/app_assets.dart';
import 'package:claxified_app/constant/app_color.dart';
import 'package:claxified_app/utils/app_routes.dart';
import 'package:claxified_app/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.bottomBarScreen);
    });
  }

  @override
  void initState() {
    _onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Scaffold(
        backgroundColor: appColor,
        body: Center(
          child: assetImage(AppAssets.appLogo, scale: 2.5),
        ),
      ),
    );
  }
}
