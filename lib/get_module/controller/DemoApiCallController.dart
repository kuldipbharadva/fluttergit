import 'package:flutter_learn_app/api_call/ApiCall.dart';
import 'package:get/get.dart';

class DemoApiCallController extends GetxController {
  var _apiRes = "".obs;
  var isLoading = false.obs;

  String get apiRes => _apiRes.string;
  set apiRes(String value) => _apiRes.value = value;

  void getApiCall() async {
    isLoading.value = true;
    ApiCall.makeApiCall(null, "https://reqbin.com/echo/get/json", MethodType.GET).then((value) {
      isLoading.value = false;
      if (value != null) {
          _apiRes.value = value.toString();
          print("api response value :: " + _apiRes.string);
      } else {
        print("api response value null :: ");
      }
    }, onError: (error) {
      isLoading.value = false;
      print("error ::: " + error.toString());
    }).catchError((onError) {
      isLoading.value = false;
      print("catchError ::: " + onError.toString());
    });
  }

 @override
  void onInit() {
    getApiCall();
    super.onInit();
  }
}