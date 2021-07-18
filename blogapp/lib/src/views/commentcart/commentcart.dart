import 'package:blogapp/src/models/blog.dart';
import 'package:flutter/material.dart';

class CommentCart extends StatelessWidget {
  final Comment comment;
  final bool delete;
  final Function(String) deleteComment;
  CommentCart(this.comment, this.delete, this.deleteComment);
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
              Text(comment.userName,
                  style: TextStyle(
                      //color: Colors.white,
                      fontFamily: "Comicsans",
                      fontWeight: FontWeight.bold)),
              Text(
                  "${comment.time.day}/${comment.time.month}/${comment.time.year}",
                  style: TextStyle(
                    fontFamily: "Comicsans",
                  ))
            ],
          ),
          Text(comment.comment,
              style: TextStyle(
                fontFamily: "Comicsans",
              )),
          SizedBox(
            height: 10,
          ),
          delete
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        this.deleteComment(this.comment.id);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red)),
                      child: Text("Delete")))
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
