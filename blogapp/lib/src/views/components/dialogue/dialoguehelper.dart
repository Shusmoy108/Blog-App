import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogueHelper {
  static showDialogue(
      {String title = "Alert!!!",
      String message = "Something went wrong. Please try again later"}) {
    Get.dialog(Dialog(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Get.textTheme.headline5,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  message,
                  style: Get.textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (Get.isDialogOpen != null && Get.isDialogOpen)
                            Get.back();
                        },
                        child: Text("Okay"))
                  ],
                )
              ],
            ))));
  }

  static showLoading({String message = "Loading..."}) {
    if (Get.isDialogOpen != null && !Get.isDialogOpen) {
      Get.dialog(Dialog(
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [CircularProgressIndicator(), Text(message)],
            )),
      ));
    }
  }

  static hideLoading() {
    if (Get.isDialogOpen != null && Get.isDialogOpen) Get.back();
  }
}
