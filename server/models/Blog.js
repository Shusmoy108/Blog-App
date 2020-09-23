const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const BlogSchema = new Schema({
  blog: String,
  time: Date,
  userName: String,
  userId: mongoose.Types.ObjectId,
  comments: [
    {
      comment: String,
      time: { type: Date, default: Date.now },
      userName: String,
      userId: mongoose.Types.ObjectId,
    },
  ],
});
BlogSchema.statics.getbloglist = function (cb) {
  var that = this;
  this.find(function (err, blogs) {
    if (err) cb("Server error", null);
    else {
      cb(null, blogs);
    }
  });
};
BlogSchema.statics.insertBlog = function (blog, user, id, cb) {
  if (blog) {
    const Blog = new this();
    Blog.blog = blog;
    Blog.time = Date.now();
    Blog.userName = user;
    Blog.userId = id;
    Blog.save(function (err, Blog) {
      if (err) {
        console.log(err);
        cb(err, null);
      } else {
        console.log(Blog);
        cb(null, Blog);
      }
    });
  } else {
    cb("Fill Up All Details", null);
  }
};
module.exports = mongoose.model("Blog", BlogSchema);
