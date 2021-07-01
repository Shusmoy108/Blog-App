import 'package:blogapp/src/controllers/usercontroller.dart';
import 'package:blogapp/src/views/pages/home/homepage.dart';
import 'package:blogapp/src/views/pages/login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  final userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    //GetStorage box = GetStorage();
    return GetMaterialApp(
        title: 'Blog App',
        defaultTransition: Transition.native,
        debugShowCheckedModeBanner: false,
        home: Obx(() {
          if (userController.islogin.value) {
            return Home();
          } else {
            return LoginScreen();
          }
        }));
  }
}
