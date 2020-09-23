import 'package:blogapp/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserApi {
  String ipiOSemu= 'http://localhost:5000/';
  String ipandroidemu= 'http://10.0.2.2:5000/';
  String ipRealdevice="";
  Future addUser(String mobile, String password)async{
          var url = ipandroidemu+"api/user"; //For Adroid Emulator

          Map<String, String> headers = new Map();
          headers['Content-Type'] = 'application/json';
          var body = json.encode({
            "mobile": mobile,
            "password":password
          });
          var response = await http.post(url, body: body, headers: headers);
          print(response.body.toString());
          bool success = jsonDecode(response.body)['success'];
          if(success){
            var user=jsonDecode(response.body)['user'];
            print(user['mobile']);
            User u = new User(user['mobile']);
            return {'success':true, 'mobile':u.mobile};
          }
          else{
            String error = jsonDecode(response.body)['error'];
            print(error);
            return {'success':false, 'error':error};
          }
  }
  Future login(String mobile, String password)async {
    var url = ipandroidemu + "api/login"; //For Adroid Emulator

    Map<String, String> headers = new Map();
    headers['Content-Type'] = 'application/json';
    var body = json.encode({
      "mobile": mobile,
      "password": password
    });
    var response = await http.post(url, body: body, headers: headers);
    print(response.body.toString());
    bool success = jsonDecode(response.body)['success'];
    if (success) {
      var user = jsonDecode(response.body)['user'];
      print(user['mobile']);
      User u = new User(user['mobile']);
      return {'success': true, 'mobile': u.mobile};
    }
    else {
      String error = jsonDecode(response.body)['error'];
      print(error);
      return {'success': false, 'error': error};
    }
  }
}