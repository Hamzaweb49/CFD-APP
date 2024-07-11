import 'package:claxified_app/api/api_helpers.dart';
import 'package:claxified_app/constant/app_request.dart';
import 'package:claxified_app/model/response_item.dart';

///SEND OTP REPO
class AuthSendOtp {
  static Future<ResponseItem> authSendOtpRepo(
      Map<String, dynamic> sendOtp) async {
    ResponseItem result = ResponseItem();
    String requestUrl = AppUrls.BASE_URL + MethodNames.authSendOtp;
    result = await BaseApiHelper.postRequest(requestUrl, sendOtp);
    return result;
  }
}

class AuthOtpLogin {
  static Future<ResponseItem> authOtpLoginRepo({
    required String mobileNo,
    required String otp,
    required String name,
  }) async {
    ResponseItem result = ResponseItem();
    String requestUrl =
        "${AppUrls.BASE_URL}${MethodNames.authOtpLogin}?mobileNo=$mobileNo&otp=$otp&firstName=$name";
    result = await BaseApiHelper.postRequest(requestUrl, {});
    return result;
  }
}
