import 'package:blogapp/src/controllers/usercontroller.dart';
import 'package:blogapp/src/models/blog.dart';
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
  final UserController userController = Get.find();
  List<bool> addComment = [];
  logout() async {
    userController.logOut();
    Get.off(LoginScreen());
  }

  void viewCommentBox(int i) {
    print("object");
    setState(() {
      addComment[i] = !addComment[i];
    });
  }

  void support(String blogId) {
    userController.addSupport(blogId);
  }

  void postcomment(comment, blogId) {
    userController.postComment(comment, blogId);
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
          child: Obx(() {
            if (userController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (userController.blogs.length != 0) {
                return ListView.separated(
                  separatorBuilder: (context, i) {
                    return SizedBox(height: 10);
                  },
                  itemCount: userController.blogs.length,
                  itemBuilder: (context, i) {
                    addComment.add(false);
                    return BlogCart(userController.blogs[i], addComment[i], i,
                        this.viewCommentBox, this.postcomment, this.support);
                  },
                );
              } else {
                return Center(
                  child:
                      Text("There is no blog at the moment. Post your blog."),
                );
              }
            }
          }),
        ),
        floatingActionButton: addblog());
  }
}

class BlogCart extends StatelessWidget {
  final Blog blog;
  final int index;
  final bool addComent;
  final Function(String comment, String id) postcomment;
  final Function(String blogId) support;
  final Function(int i) view;
  final TextEditingController commentEditor = new TextEditingController();
  BlogCart(this.blog, this.addComent, this.index, this.view, this.postcomment,
      this.support);
  List<Widget> getcomments() {
    List<Widget> childs = [];
    for (var i = 0; i < blog.comments.length; i++) {
      childs.add(CommentCart(blog.comments[i].userName,
          blog.comments[i].comment, blog.comments[i].time));
      childs.add(Divider(
        thickness: 1,
        color: Colors.grey,
      ));
    }
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    blog.userName,
                    style: TextStyle(
                        fontFamily: "Lucidasans", fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${blog.time.day}-${blog.time.month}-${blog.time.year}",
                    style: TextStyle(
                        fontFamily: "Lucidasans", fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(blog.blog,
                  style: TextStyle(
                    fontFamily: "Lucidasans",
                  )),
              SizedBox(
                height: 10,
              ),
              Text("${blog.supports.length} people support this blog",
                  style: TextStyle(
                    fontFamily: "Lucidasans",
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        this.support(blog.id);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: Text("Support",
                          style: TextStyle(
                            fontFamily: "Lucidasans",
                          ))),
                  Visibility(
                      visible: !addComent,
                      child: ElevatedButton(
                          onPressed: () {
                            this.view(index);
                          },
                          child: Text("Add Comment"))),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                  visible: addComent,
                  child: CommentInput("Comment", commentEditor)),
              Visibility(
                  visible: addComent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            this.view(index);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          child: Text("Close",
                              style: TextStyle(
                                fontFamily: "Lucidasans",
                              ))),
                      ElevatedButton(
                          onPressed: () {
                            this.postcomment(commentEditor.text, blog.id);
                            this.view(index);
                          },
                          child: Text("Post Comment")),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              (blog.comments.length != 0)
                  ? ExpansionTile(
                      leading: Icon(Icons.comment),
                      title: Text("View Comments"),
                      children: getcomments(),
                    )
                  : Center(
                      child: Text(
                      "Be the first one to comment in this blog.",
                      style: TextStyle(
                        fontFamily: "Lucidasans",
                      ),
                    ))
            ],
          )),
    );
  }
}

class CommentInput extends StatelessWidget {
  final String label;
  final TextEditingController textEditingController;
  CommentInput(this.label, this.textEditingController);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      //color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: "Lucidasans",
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(

              //padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              //color: Colors.white,
              child: TextFormField(
            controller: textEditingController,
            maxLines: 3,
            style: TextStyle(
                fontFamily: "Lucidasans",
                fontSize: 19,
                color: Color(0xff0962ff),
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              //hintText: widget.inputHint,
              hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[350],
                  fontWeight: FontWeight.w600),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 27, horizontal: 25),
              focusColor: Color(0xff0962ff),
              filled: true,
              fillColor: Colors.grey.shade300,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class CommentCart extends StatelessWidget {
  final String name;
  final String comment;
  final DateTime date;
  CommentCart(this.name, this.comment, this.date);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name,
                  style: TextStyle(
                      //color: Colors.white,
                      fontFamily: "Comicsans",
                      fontWeight: FontWeight.bold)),
              Text("${date.day}/${date.month}/${date.year}",
                  style: TextStyle(
                    fontFamily: "Comicsans",
                  ))
            ],
          ),
          Text(comment,
              style: TextStyle(
                fontFamily: "Comicsans",
              )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
