const express = require("express");
const blogRouter = express.Router();
const Blogs = require("../models/Blog");

blogRouter.get("/show", function (req, res) {
  console.log("here");
  Blogs.getbloglist(function (err, blogs) {
    if (err) {
      return res.status(500).send({ success: false, msg: "Server Error." });
    } else {
      console.log(blogs);
      return res.json({ success: true, data: blogs });
    }
  });
});

blogRouter.post("/add", function (req, res) {
  Blogs.insertBlog(req.body.blog, req.body.user, req.body.id, function (
    status,
    err,
    blog
  ) {
    if (err) {
      return res.status(500).send({ success: false, msg: "Server Error." });
    } else {
      console.log(blogs);
      Blogs.getbloglist(function (status,err, blogs) {
        if (err) {
          return res.status(500).send({ success: false, msg: "Server Error." });
        } else {
          return res.json({ success: true, data: blogs });
        }
      });
    }
  });
});

blogRouter.post("/delete", function (req, res) {
  console.log("Blog");
  Blogs.remove({ _id: req.body.id }, function (err) {
    if (err) {
      return res.status(500).send({ success: false, msg: "Server Error." });
    } else {
      Blogs.getbloglist(function (err, blogs) {
        if (err) {
          return res.status(500).send({ success: false, msg: "Server Error." });
        } else {
          return res.json({ success: true, data: blogs });
        }
      });
    }
  });
});

blogRouter.post("/addcomment", function (req, res) {
  console.log(req.body.id);
  var comment = {
    comment: req.body.comment,
    time: Date.now(),
  };
  Blogs.findByIdAndUpdate(
    req.body.id,
    { $push: { comments: comment } },
    { safe: true, upsert: true },
    function (err, model) {
      if (err) {
        console.log(err);
        return res.status(500).send({ success: false, msg: "databswr Error." });
      } else {
        Blogs.getbloglist(function (err, blogs) {
          if (err) {
            return res
              .status(500)
              .send({ success: false, msg: "Server Error." });
          } else {
            return res.json({ success: true, data: blogs });
          }
        });
      }
    }
  );
});
blogRouter.post("/deletecomment", function (req, res) {
  console.log(req.body.id);
  Blogs.findByIdAndUpdate(
    req.body.id,
    { $pull: { comments: { _id: req.body.comment_id } } },
    function (err, model) {
      if (err) {
        console.log(err);
        return res.status(500).send({ success: false, msg: "databswr Error." });
      } else {
        Blogs.getbloglist(function (err, blogs) {
          if (err) {
            return res
              .status(500)
              .send({ success: false, msg: "Server Error." });
          } else {
            return res.json({ success: true, data: blogs });
          }
        });
      }
    }
  );
});

module.exports = blogRouter;
