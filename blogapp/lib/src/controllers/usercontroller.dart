import 'dart:convert';

import 'package:blogapp/src/controllers/errorcontroller.dart';
import 'package:blogapp/src/models/blog.dart';
import 'package:blogapp/src/services/baseclient.dart';
import 'package:blogapp/src/views/components/dialogue/dialoguehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

class UserController extends GetxController with ErrorController {
  var islogin = false.obs;
  final box = GetStorage();
  var number = "".obs;
  var name = "".obs;
  var id = "".obs;
  List<Blog> blogs = List<Blog>.empty().obs;

  var isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();

    if (box.hasData("mobile")) {
      number.value = box.read("mobile");
      name.value = box.read("name");
      id.value = box.read("id");
      loadBlog();
      islogin.value = true;
    }
  }

  Future<bool> loadBlog() async {
    var res = await BaseClient().get("/blogs/show").catchError(handleError);
    if (res == null) return false;
    blogs.clear();

    for (var b in res['data']) {
      blogs.add(Blog.fromJson(b));
    }

    //blogs = blogList;
    return true;
    //blogs.value = blogList;
  }

  void getConnect() async {
    var res = await BaseClient().get("/api/ola").catchError(handleError);
  }

  Future<bool> signUp(String user, String mobile, String password) async {
    var res = await BaseClient().post("/api/add", {
      "name": user,
      "mobile": mobile,
      "password": password
    }).catchError(handleError);

    if (res == null) return false;
    if (!res['success']) {
      Get.snackbar("Error", "You are already registered with this number.",
          backgroundColor: Colors.red);
    } else {
      box.write('mobile', mobile);
      var resp = res['data'];
      box.write('id', resp['_id']);
      box.write('name', resp['name']);
      number.value = box.read("mobile");
      name.value = box.read("name");
      id.value = box.read("id");
      islogin.value = await loadBlog();
    }
    return res["success"];
  }

  Future<bool> logIn(String mobile, String password) async {
    var res = await BaseClient().post("/api/login",
        {"mobile": mobile, "password": password}).catchError(handleError);

    if (res == null) return false;
    if (!res['success']) {
      Get.snackbar("Error", res['msg'], backgroundColor: Colors.red);
    } else {
      box.write('mobile', mobile);
      var resp = res['data'];
      box.write('id', resp['_id']);
      box.write('name', resp['name']);
      number.value = box.read("mobile");
      name.value = box.read("name");
      id.value = box.read("id");
      islogin.value = await loadBlog();
      print(blogs.length);
    }
    return res["success"];
  }

  Future postBlog(String blog) async {
    var res = await BaseClient().post("/blogs/add", {
      "blog": blog,
      "user": name.value,
      "id": id.value
    }).catchError(handleError);
    loadBlog();
  }

  Future postComment(String comment, String blogId) async {
    var res = await BaseClient().post("/blogs/addcomment", {
      "comment": comment,
      "user": name.value,
      "id": id.value,
      "blogid": blogId,
      "mobile": number.value
    }).catchError(handleError);

    loadBlog();
  }

  Future myBlogs() async {
    String api = "/blogs/myblog/" + id.value;
    var res = await BaseClient().get(api).catchError(handleError);
    return res;
  }

  Future addSupport(String blogId) async {
    var res = await BaseClient().post("/blogs/support", {
      "user": name.value,
      "id": id.value,
      "blogid": blogId,
      "mobile": number.value
    }).catchError(handleError);

    if (!res['success']) {
      DialogueHelper.showDialogue(
          title: "Oopss!!", message: "You have already supported this blog");
    } else {
      DialogueHelper.showDialogue(
          title: "Success",
          message: "You have successfully supported this blog.");
    }
    loadBlog();
  }

  void logOut() {
    box.remove('mobile');
    box.remove('name');
    box.remove('id');
  }
}
