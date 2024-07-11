import 'package:flutter/foundation.dart';

// import '../constant/requst_const.dart';

void printData({required dynamic tittle, dynamic val}) {
  if (kDebugMode) {
    print("$tittle:-$val");
  }
}

// Map<String, String> requestHeader() {
//   return {
//     RequestHeaderKey.bearerToken:
//         "Bearer {cOq-cAGoaVox2nSveyhMOsnvfdyq-t=uCSU}",
//   };
// }

String errorText = "Something went wrong";
String statusText = "Success";

Map<String, String> requestHeader() {
  // return {
  //   "content-type": "application/json",
  //   "accept": "text/plain",
  //   // if (passAuthToken)
  //   //   RequestHeaderKey.authToken:
  //   //       preference.getString(SharedPreference.AUTH_TOKEN_KEY) ?? '',
  // };
  return {'accept': 'text/plain', 'Content-Type': 'application/json'};
}
