import 'package:blogapp/src/controllers/usercontroller.dart';
import 'package:blogapp/src/models/blog.dart';
import 'package:blogapp/src/views/blogcart/blogcart.dart';
import 'package:blogapp/src/views/components/input/bloginput.dart';
import 'package:blogapp/src/views/pages/login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserController userController = Get.find();
  List<Blog> myblogs = [];
  List<bool> addComment = [];
  int x = 0;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void viewCommentBox(int i) {
    print("object");
    setState(() {
      addComment[i] = !addComment[i];
    });
  }

  logout() async {
    userController.logOut();
    Get.off(LoginScreen());
  }

  loadData() async {
    var res = await userController.myBlogs();
    List<Blog> blogs = [];
    print(res);
    for (var b in res["data"]) {
      blogs.add(Blog.fromJson(b));
    }
    setState(() {
      myblogs = blogs;
      x = blogs.length;
    });
  }

  void support(String blogId) {
    userController.addSupport(blogId);
  }

  void postcomment(comment, blogId) {
    userController.postComment(comment, blogId);
  }

  List<Widget> getBlogs() {
    List<Widget> childs = [];
    childs.add(
      Row(
        //mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //   child:
          // CircleAvatar(
          // backgroundColor: Colors.white,
          // child:
          Icon(
            Icons.person,
            size: 100,
            //),
          ),
          //SizedBox(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                userController.name.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                userController.number.toString(),
                style: TextStyle(fontSize: 17, color: Colors.blue),
              ),
            ],
          ))
        ],
      ),
    );
    childs.add(
      Container(
        child: Center(
          child: ElevatedButton(
              onPressed: () {
                logout();
                // Navigator.of(context).push(UpdateProfile(
                //     accountController.user, this.updateProfile));
              },
              child: Text("Update Profile")),
        ),
      ),
    );
    childs.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("My Blogs"), Text("Total $x blogs posted")]));
    childs.add(Divider(
      thickness: 1,
    ));
    for (var i = 0; i < this.myblogs.length; i++) {
      addComment.add(false);
      childs.add(BlogCart(userController.blogs[i], addComment[i], i,
          this.viewCommentBox, this.postcomment, this.support));
      childs.add(SizedBox(
        height: 10,
      ));
    }
    if (childs.length == 3) {
      childs
          .add(Text("You still did not post any blog. Post your first blog."));
    }
    return childs;
  }

  final TextEditingController textEditingController =
      new TextEditingController();
  Widget addblog() {
    return InkWell(
      onTap: () {
        //logout();
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
                      onPressed: () {
                        userController.postBlog(textEditingController.text);
                        textEditingController.clear();
                        if (Get.isBottomSheetOpen) Get.back();
                      },
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
        body: Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: getBlogs(),
            )),
        floatingActionButton: addblog());
  }
}
