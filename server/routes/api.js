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

  apiRouter.post("/add", function (req, res) {
    User.addUser (req.body.name, req.body.mobile, req.body.password, function (
      status,
      err,
      user
    ) {
      if(status===200){
        //Blogs.getbloglist(function (err, blogs) {
          return res.json({ success: true, data: user });
      }
      else if (status===400) {
        //Blogs.getbloglist(function (err, blogs) {
          return res.json({ success: false, data: user });
      }
      else{
        
          return res.status(500).send({ success: false, msg: "Server Error." });
        
      }
    } 
        
        )
      });
      apiRouter.post("/login", function (req, res) {
       console.log(req.body);
        User.getUser (req.body.mobile, req.body.password, function (
          status,
          err,
          user
        ) {
         
            if(status===200){
              //Blogs.getbloglist(function (err, blogs) {
                return res.json({ success: true, data: user });
            }
            else if (status===400||status==401) {
              //Blogs.getbloglist(function (err, blogs) {
                return res.json({ success: false, msg: err });
            }
            else{
              
                return res.status(500).send({ success: false, msg: "Server Error." });
              
            }
              
            })
          });
      apiRouter.get("/ola", function (req, res) {
        console.log("ola");
        return res.json({ success: true, data: "user" })});
       
module.exports = apiRouter;
