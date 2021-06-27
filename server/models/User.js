"use strict";
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ProfilesSchema = new Schema({
  name: String,
  mobile: String,
  password: String,
});

ProfilesSchema.statics.addUser = function (name, mobile, password, cb) {
  if (name) {
    const User = new this();
    User.name = name;
    User.mobile = mobile;
    User.password = password;
    User.save(function (err, Blog) {
      if (err) {
        console.log(err);
        cb(err, null);
      } else {
        console.log(User);
        cb(null, User);
      }
    });
  } else {
    cb("Fill Up All Details", null);
  }
};
module.exports = mongoose.model("Profiles", ProfilesSchema);
