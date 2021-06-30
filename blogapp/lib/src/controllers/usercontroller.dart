import 'package:blogapp/src/controllers/errorcontroller.dart';
import 'package:blogapp/src/services/baseclient.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

class UserController extends GetxController with ErrorController {
  var islogin = false.obs;
  final box = GetStorage();
  var mobile = "".obs;
  @override
  void onInit() {
    super.onInit();
    if (box.hasData("mobile")) {
      mobile.value = box.read("mobile");
      islogin.value = true;
    }
  }

  void getConnect() async {
    var res = await BaseClient().get("/api/ola").catchError(handleError);
    print(res);
  }

  Future<bool> signUp(String name, String mobile, String password) async {
    var res = await BaseClient().post("/api/add", {
      "name": name,
      "mobile": mobile,
      "password": password
    }).catchError(handleError);
    print(res);
    if (res == null) return false;
    return res["success"];
  }

  Future<bool> logIn(String mobile, String password) async {
    var res = await BaseClient().post("/api/login",
        {"mobile": mobile, "password": password}).catchError(handleError);
    print(res);
    box.write('mobile', mobile);
    if (res == null) return false;

    return res["success"];
  }

  void logOut() {
    box.remove('mobile');
  }
}
