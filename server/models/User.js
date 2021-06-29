"use strict";
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ProfilesSchema = new Schema({
  name: String,
  mobile: String,
  password: String,
});

ProfilesSchema.statics.getUser = function (mobile,password,cb) {
  var that = this;
  this.findOne({"mobile":mobile},function (err, user) {
    if (err) cb("Server error", null);
    else {
      if(user.password==password){
        cb(null,user);
      }
      else{
        cb("Wrong password", null);
      }
     
    }
  });
};

ProfilesSchema.statics.addUser = function (name, mobile, password, cb) {
 
  if (name) {
    const User = new this();
    User.name = name;
    User.mobile = mobile;
    User.password = password;
    User.save(function (err, user) {
      console.log(err);
      if (err) {
        console.log(err);
        cb(err, null);
      } else {
        console.log(user);
        cb(null, user);
      }
    });
  } else {
    console.log("User.save");
    cb("Fill Up All Details", null);
  }
};
module.exports = mongoose.model("Profiles", ProfilesSchema);
