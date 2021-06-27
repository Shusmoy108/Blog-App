import 'package:blogapp/src/controllers/errorcontroller.dart';
import 'package:blogapp/src/services/baseclient.dart';

class UserController with ErrorController {
  void getConnect() async {
    var res = await BaseClient().get("/api/ola").catchError(handleError);
    print(res);
  }
}
