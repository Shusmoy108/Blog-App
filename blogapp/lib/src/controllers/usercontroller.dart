import 'package:blogapp/src/controllers/errorcontroller.dart';
import 'package:blogapp/src/services/baseclient.dart';

class UserController with ErrorController {
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
    if (res == null) return false;
    return res["success"];
  }
}
