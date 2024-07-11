import 'dart:developer';
import 'package:claxified_app/api/repo/profile_screen_repo.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:claxified_app/theme/app_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FeedBackController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController feedBackDescription = TextEditingController();
  TextEditingController feedBackTitle = TextEditingController();
  final formKey = GlobalKey<FormState>();

  /// add wish List data
  addFeedBackData({required Map<String, dynamic> feedBackData}) async {
    isLoading.value = true;
    ResponseItem result;
    result =
        await GetAllProfileData.addFeedBackRepo(feedBackData: feedBackData);
    try {
      if (result.status == true) {
        showSuccessSnackBar('Submit Successfully');
        isLoading.value = false;
        log("------Successfully-------");
        update();
      } else {
        isLoading.value = false;
        showSuccessSnackBar('Something Went Wrong,Please Try Again');
      }
    } catch (e) {
      log('ERROR====addFeedBackData===>>>>====>>>>$e');
      isLoading.value = false;
    }
    update();
  }
}
