import 'package:blogapp/src/views/pages/home/homepage.dart';
import 'package:blogapp/src/views/pages/login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  Future<bool> loadAuthData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool('auth');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BoilerPlate ',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: loadAuthData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return Home("");
            } else {
              return LoginScreen();
            }
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
