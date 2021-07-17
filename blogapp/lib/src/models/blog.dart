import 'dart:convert';

Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));

String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
  Blog({
    required this.id,
    required this.comments,
    required this.blog,
    required this.time,
    required this.userName,
    required this.userId,
    required this.v,
    required this.supports,
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
    required this.id,
    required this.comment,
    required this.mobile,
    required this.time,
    required this.userName,
    required this.userId,
  });

  String id;
  String comment;
  DateTime time;
  String userName;
  String mobile;
  String userId;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        comment: json["comment"] == null ? "" : json["comment"],
        mobile: json["mobile"] == null ? "" : json["mobile"],
        time: DateTime.parse(json["time"]),
        userName: json["userName"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "comment": comment,
        "mobile": mobile,
        "time": time.toIso8601String(),
        "userName": userName,
        "userId": userId,
      };
}
