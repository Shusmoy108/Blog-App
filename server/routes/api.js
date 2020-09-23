const express = require("express");
const apiRouter = express.Router();

const User = require("../models/User");

apiRouter
  .route("/user")
  .get(function (req, res) {
    User.find(function (err, users) {
      if (err) res.send(err);
      res.json(users);
    });
  })
  .post(function (req, res) {
    // const user = new User();
    // user.name = req.body.name;
    // user.mobile = req.body.mobile;
    // user.password = req.body.password;

    console.log(req.body);
    return res.json({ success: false, error: "Internal Server down" });
    // User.save(function (err, doc) {
    //   if (err) res.send(err);
    //   res.json(doc);
    // });
  });

module.exports = apiRouter;
