import 'package:blogapp/src/views/pages/home/homepage.dart';
import 'package:blogapp/src/views/pages/login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    //GetStorage box = GetStorage();
    return GetMaterialApp(
        title: 'Blog App',
        defaultTransition: Transition.native,
        debugShowCheckedModeBanner: false,
        home: box.hasData("mobile") ? Home() : LoginScreen());
  }
}
