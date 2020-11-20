const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const express = require("express");
// var admin = require("firebase-admin");

// var serviceAccount = require("./serviceAccountKey.json");

// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
//   databaseURL: "https://hackforshe2020.firebaseio.com"
// });

app = express();


app.engine("html", require("ejs").renderFile);

app.use(bodyParser.json());
app.use(cookieParser());

app.use(express.static(__dirname + "/public"));

app.get("/login", function (req, res) {
    res.render("admin_signin.html");
  });
  
  app.get("/signup", function (req, res) {
    res.render("admin_signup.html");
  });

app.get("/", function (req, res) {
    res.render("index.html");
  });

const userRouter = require('./routes/user');
app.use('/',userRouter);

app.get("/projects", (req,res)=>{
    res.render("projects.html");
})

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Server started at port ${port}`)); 