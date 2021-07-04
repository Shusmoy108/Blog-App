const express = require("express");
const blogRouter = express.Router();
const Blogs = require("../models/Blog");

blogRouter.get("/show", function (req, res) {
 
  Blogs.getbloglist(function (status,err, blogs) {
    if (err) {
      return res.status(500).send({ success: false, msg: "Server Error." });
    } else {
    
      return res.json({ success: true, data: blogs });
    }
  });
});
blogRouter.get("/myblog/:id", function (req, res) {
 console.log(req.params.id);
  Blogs.getmybloglist(req.params.id,function (status,err, blogs) {
    if (err) {
      console.log(err);
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
      console.log(blog);
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
 
  var comment = {
    comment: req.body.comment,
    time: Date.now(),
    mobile:req.body.mobile,
    userName:req.body.user,userId:req.body.id 
  };
  Blogs.addComment(comment, req.body.blogid, function (
    status,
    err,
    blog
  ) {
    if (err) {
      return res.status(500).send({ success: false, msg: "Server Error." });
    } else {
      console.log(blog);
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

blogRouter.post("/support", function (req, res) {
 
  var support = {
    time: Date.now(),
    userName:req.body.user,
    mobile:req.body.mobile,
    userId:req.body.id 
    
  };
  console.log(support);
  Blogs.addSupport(support, req.body.blogid,req.body.mobile, function (
    status,
    err,
    blog
  ) {
    if(status===200){
      Blogs.getbloglist(function (status,err, blogs) {
        if (err) {
          return res.status(500).send({ success: false, msg: "Server Error." });
        } else {
          return res.json({ success: true, data: blogs });
        }
      });
      
    }
    else if(status===400){
      return res.json({ success: false, data: err });
    }
    else {
      return res.status(500).send({ success: false, msg: "Server Error." });
    } 

  });
 
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
