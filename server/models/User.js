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
        cb(200,null,user);
      }
      else{
        cb(400,"Wrong password", null);
      }
     
    }
  });
};

ProfilesSchema.statics.addUser = function (name, mobile, password, cb) {
 var that=this;
  if (name) {
    that.findOne({"mobile":mobile},function (err, user) {
      if (err) cb(500,"Server error", null);
      else if(user){
        cb(400,"You are registered", null);
      }
      else {
        const User = new that();
        User.name = name;
        User.mobile = mobile;
        User.password = password;
        User.save(function (err, user) {
          console.log(err);
          if (err) {
            console.log(err);
            cb(500,err, null);
          } else {
            console.log(user);
            cb(200,null, user);
          }
        });
      } })}
       
      
  
   
};
module.exports = mongoose.model("Profiles", ProfilesSchema);
