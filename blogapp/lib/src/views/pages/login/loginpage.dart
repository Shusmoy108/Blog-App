import 'package:blogapp/src/controllers/usercontroller.dart';
import 'package:blogapp/src/views/components/input/passwordinput.dart';
import 'package:blogapp/src/views/components/input/textinput.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenForm createState() => LoginScreenForm();
}

class LoginScreenForm extends State<LoginScreen> {
  final TextEditingController numberController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool register = false, obsecure = false;

  void signUp() {
    setState(() {
      register = !register;
    });
  }

  void changeObsecure() {
    setState(() {
      obsecure = !obsecure;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        color: Colors.white,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            //height: 300,
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextInput("Mobile Number", numberController),
                Visibility(
                  visible: register,
                  child: TextInput("User Name", nameController),
                ),
                PasswordInput(obsecure, passwordController, changeObsecure),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                        visible: !register,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          onPressed: () async {
                            bool success = await UserController().logIn(
                                numberController.text, passwordController.text);
                            print(success);
                          },
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                    fontFamily: "Lucidasans", fontSize: 20),
                              )),
                        )),
                    Visibility(
                        visible: register,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          onPressed: () {
                            this.signUp();
                          },
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "< Back",
                                style: TextStyle(
                                    fontFamily: "Lucidasans", fontSize: 20),
                              )),
                        )),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                      onPressed: () async {
                        if (!register) {
                          this.signUp();
                        } else {
                          bool x = await UserController().signUp(
                              nameController.text,
                              numberController.text,
                              passwordController.text);
                          print(x);
                        }
                      },
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontFamily: "Lucidasans", fontSize: 20),
                          )),
                    )
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                border: Border.all()),
          ),
        ),
      ),
    );
  }
}
