import 'dart:developer';

import 'package:claxified_app/api/repo/home_screen_repo.dart';
import 'package:claxified_app/model/response_item.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MyWishListController extends GetxController {
  RxBool isLoading = false.obs;

  /// add wish List data
  addWishListData({required Map<String, dynamic> wishListData}) async {
    // isLoading.value = true;
    ResponseItem result;
    result = await AddWishListRepo.addWishListRepo(wishListData: wishListData);
    try {
      if (result.status == true) {
        //  showSuccessSnackBar('Publish Successfully');
        //  isLoading.value = false;
        log("------Successfully-------");
        update();
      } else {
        // isLoading.value = false;
        //    showSuccessSnackBar('Something Went Wrong,Please Try Again');
        log('Something Went Wrong,Please Try Again');
      }
    } catch (e) {
      log('ERROR====addWishListData===>>>>====>>>>$e');
      //  isLoading.value = false;
    }
    update();
  }
}
