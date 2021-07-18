import 'package:blogapp/src/controllers/usercontroller.dart';
import 'package:blogapp/src/models/blog.dart';
import 'package:blogapp/src/views/commentcart/commentcart.dart';
import 'package:blogapp/src/views/components/input/commentinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogCart extends StatelessWidget {
  final Blog blog;
  final int index;
  final bool addComent;
  final Function(String comment, String id) postcomment;
  final Function(String blogId) support;
  final Function(int i) view;
  final TextEditingController commentEditor = new TextEditingController();
  final UserController userController = Get.find();
  BlogCart(this.blog, this.addComent, this.index, this.view, this.postcomment,
      this.support);

  void deleteComment(String commentId) {
    userController.deleteComment(commentId, blog.id);
  }

  List<Widget> getcomments() {
    List<Widget> childs = [];
    for (var i = 0; i < blog.comments.length; i++) {
      bool delete = (blog.userId.trim() == userController.id.trim()) ||
          (blog.comments[i].userId.trim() == userController.id.trim());

      childs.add(CommentCart(blog.comments[i], delete, deleteComment));
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
                      title: Text("View Comments (${blog.comments.length})"),
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
