const express = require("express");
const path = require("path");
const mongoose = require("mongoose");
const cors = require("cors");
const bodyParser = require("body-parser");
const port = process.env.PORT || 5000;
const config = require("./settings/config");

const app = express();
const { MongoClient } = require('mongodb');
const uri = "mongodb+srv://shusmoy13:Sucharita13@cluster0.apbbh.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });
client.connect(err => {
  const collection = client.db("test").collection("devices");
  //print(collection);
  console.error(err);
  // perform actions on the collection object
  client.close();
});
mongoose.Promise = require("bluebird");
// MongoClient
//   .connect(config.dbUrl, { useUnifiedTopology: true, useNewUrlParser: true })
//   .then(() => {
//     // if all is ok we will be here
//     console.log("Db initialized");
//   })
//   .catch((err) => {
//     // if error we will be here
//     print(err);
//     console.error("DB starting error");
//     //process.exit(1);
//   });

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.use(function (req, res, next) {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Credentials", "true");
  res.setHeader(
    "Access-Control-Allow-Methods",
    "GET,HEAD,OPTIONS,POST,PUT,DELETE"
  );
  res.setHeader(
    "Access-Control-Allow-Headers",
    "Access-Control-Allow-Headers, Origin,Accept," +
    "X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers"
  );
  res.setHeader("Cache-Control", "no-cache");
  next();
});

// Serve static files from the React app

app.use(express.static(path.join(__dirname, "client/build")));
const apiRouter = require("./routes/api");
app.use("/api", apiRouter);

const blogRouter = require("./routes/blog");
app.use("/blogs", blogRouter);

app.use(express.static(process.cwd() + "/public"));

app.use(function (req, res) {
  res.status(404).send({ url: req.originalUrl + " not found" });
});

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname + "/client/build/index.html"));
});

app.listen(port);
console.log(`Blog-App listening on ${port}`);
