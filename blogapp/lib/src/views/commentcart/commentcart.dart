import 'package:flutter/material.dart';

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
