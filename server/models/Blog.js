const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const BlogSchema = new Schema({
  blog: String,
  time: Date,
  userName: String,
  userId: mongoose.Types.ObjectId,
  support:[],
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
    if (err) cb(500,"Server error", null);
    else {
      cb(200,null, blogs);
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
        cb(500,err, null);
      } else {
        cb(200,null, Blog);
      }
    });
  } else {
    cb(401,"Fill Up All Details", null);
  }
};
module.exports = mongoose.model("Blog", BlogSchema);
