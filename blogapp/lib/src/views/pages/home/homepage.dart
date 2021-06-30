import 'package:blogapp/src/views/components/input/bloginput.dart';
import 'package:blogapp/src/views/components/input/textinput.dart';
import 'package:blogapp/src/views/pages/login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  logout() async {
    Get.off(LoginScreen());
  }

  final TextEditingController textEditingController =
      new TextEditingController();
  Widget addblog() {
    return InkWell(
      onTap: () {
        Get.bottomSheet(Container(
          color: Colors.grey.shade300,
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Center(
                  child: Text("Post Your Blog",
                      style: TextStyle(
                        fontFamily: "Lucidasans",
                        fontSize: 18,
                        color: Colors.black,
                      ))),
              Divider(
                thickness: 2,
                color: Colors.black,
              ),
              BlogInput(textEditingController),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Text("Post",
                          style: TextStyle(
                            fontFamily: "Lucidasans",
                          )))
                ],
              )
            ],
          ),
        ));
      },
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            //BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Add Blog',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontFamily: 'Lucidasans'),
            ),
            SizedBox(
              width: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "BlogApp",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: "Lucidasans",
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(),
        floatingActionButton: addblog());
  }
}
