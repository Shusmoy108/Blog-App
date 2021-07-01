import 'dart:convert';

Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));

String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
  Blog({
    this.id,
    this.comments,
    this.blog,
    this.time,
    this.userName,
    this.userId,
    this.v,
    this.supports,
  });

  String id;
  List<Comment> comments;
  String blog;
  DateTime time;
  String userName;
  String userId;
  int v;
  List<Comment> supports;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["_id"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        blog: json["blog"],
        time: DateTime.parse(json["time"]),
        userName: json["userName"],
        userId: json["userId"],
        v: json["__v"],
        supports: List<Comment>.from(
            json["supports"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "blog": blog,
        "time": time.toIso8601String(),
        "userName": userName,
        "userId": userId,
        "__v": v,
        "supports": List<dynamic>.from(supports.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    this.id,
    this.comment,
    this.time,
    this.userName,
    this.userId,
  });

  String id;
  String comment;
  DateTime time;
  String userName;
  String userId;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        comment: json["comment"] == null ? null : json["comment"],
        time: DateTime.parse(json["time"]),
        userName: json["userName"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "comment": comment == null ? null : comment,
        "time": time.toIso8601String(),
        "userName": userName,
        "userId": userId,
      };
}
