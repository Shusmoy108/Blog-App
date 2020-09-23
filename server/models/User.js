"use strict";
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const ProfilesSchema = new Schema({
  name: String,
  mobile: String,
  password: String,
});

module.exports = mongoose.model("Profiles", ProfilesSchema);
