const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const BlogSchema = new Schema({
  blog: String,
  time: Date,
  userName: String,
  userId: mongoose.Types.ObjectId,
  supports:[{  
    userName: String,
    mobile:String,
    time: { type: Date, default: Date.now },
    userId: mongoose.Types.ObjectId,}],
  comments: [
    {
      comment: String,
      time: { type: Date, default: Date.now },
      userName: String,
      mobile:String,
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
BlogSchema.statics.getmybloglist = function (id,cb) {
  var that = this;
  this.find({userId:id},function (err, blogs) {
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
    Blog.comments=[];
    Blog.supports=[];
    Blog.save(function (err, Blog) {
      console.log(Blog);
      if (err) {
        console.log(err);
        cb(500,err, null);
      } else {
        cb(200,null, Blog);
      }
    });
  } else {
    cb(401,"Fill Up All Details", null);
  }
};

BlogSchema.statics.addComment = function (comment ,blogid,cb) {
  var that = this;

  this.findByIdAndUpdate( blogid,
    { $push: { comments:comment } },
    { safe: true, upsert: true },
    function (err, model) {
      if (err) {
        console.log(err);
        cb(500,err, null);
      } else {

            cb(200,null, model);}
          
        
      
    });
    
};
BlogSchema.statics.deleteComment = function ( blogid, commentid,cb) {
  var that = this;
that.findByIdAndUpdate(
  blogid,
  { $pull: { comments: { _id: commentid } } },
  function (err, model) {
    if (err) {
      console.log(err);
      cb(500,err, null);
    } else {
      cb(200,null, model);
    }
  }
);
}
BlogSchema.statics.addSupport = function (support ,blogid,mobile,cb) {
  var that = this;
  // that.findByIdAndUpdate(
  //    blogid,  
  //   {$set:{
  //     supports:{
  //         $cond:{
  //           if: {$in: ["name", "$supports.userName"]},
  //           then: "$supports",
  //           else: {$concatArrays: ["$supports", [support]]}
  //         }
  //     }}},
  //   // { safe: true, upsert: true },
  //   function (err, model) {
  //     if (err) {
  //       console.log(err);
  //       cb(500,err, null);
  //     } else {

  //           cb(200,null, model);}
          
        
      
  //   });
  
    that.findById(blogid,
   function(err, blog){
    console.log(blog.supports);
    let found=false;
    for (var i=0; i < blog.supports.length; i++) {
      if (blog.supports[i].mobile ===mobile) {
          found=true;
          break;
      }
  }
   
    console.log(found);
    if(!found){
      
      that.findByIdAndUpdate( blogid,
        { $push: { supports:support } },
        { safe: true, upsert: true },
        function (err, model) {

          if (err) {
            console.log(err);
            cb(500,err, null);
          } else {
    
                cb(200,null, model);}
              
            
          
        });
    }
    else{
      cb(400,"Already supported", null);
    }
    
   
     
  });
  // that.updateOne( {_id:mongoose.Types.ObjectId(blogid),'supports.userName':{$ne: name}},
  //   { $push: { supports:support } },
  //   { safe: true, upsert: true },
  //   function (err, model) {
  //     if (err) {
  //       console.log(err);
  //       cb(500,err, null);
  //     } else {

  //           cb(200,null, model);}
          
        
      
  //   });
    
};
module.exports = mongoose.model("Blog", BlogSchema);
