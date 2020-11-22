const express = require('express');
const userRouter = express.Router();

var admin = require("firebase-admin");

var serviceAccount = require("../serviceAccountKey2.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://swarksha.firebaseio.com"
  });

const db = admin.database();

userRouter.get('/lalaname', (req, res) => {
    // let maindata = {name: "", loc: null};
    // var name;
    db.ref('User').once('value', (snapshot) => {
       data = snapshot.val();
    //    console.log("hahaha",data)
    //    console.log("hahaha",data.LV5BA0xP0cbtQUcu8b1pgOprBWh2['First Name'])
    //    console.log("hahaha",data)
       res.json({name: data.LV5BA0xP0cbtQUcu8b1pgOprBWh2['First Name'] + " " + data.LV5BA0xP0cbtQUcu8b1pgOprBWh2['Last Name']})
    //    res.render('index', {contacts: data})

    console.log(data.LV5BA0xP0cbtQUcu8b1pgOprBWh2['First Name'] + " " + data.LV5BA0xP0cbtQUcu8b1pgOprBWh2['Last Name'])

    // maindata.name = data.LV5BA0xP0cbtQUcu8b1pgOprBWh2['First Name'] + data.LV5BA0xP0cbtQUcu8b1pgOprBWh2['Last Name']
    });
})

userRouter.get('/lalaloc', (req, res) => {

    db.ref('Emergency').once('value', (snapshot) => {
       data = snapshot.val();
        // console.log("hahaha",data)
        // console.log("hahaha",data.users.urgent.LV5BA0xP0cbtQUcu8b1pgOprBWh2)
        // data = data.users.urgent.LV5BA0xP0cbtQUcu8b1pgOprBWh2;
        // console.log("hahaha",data)
        res.json({loc: data.users.urgent.LV5BA0xP0cbtQUcu8b1pgOprBWh2})
     //    res.render('index', {contacts: data})
     });
})

userRouter.get("/profile", function (req, res) {
    const sessionCookie = req.cookies.session || "";
  
    admin
      .auth()
      .verifySessionCookie(sessionCookie, true /** checkRevoked */)
      .then(() => {
        res.render("profile.html");
      })
      .catch((error) => {
        res.redirect("/login");
      });
  });

  userRouter.get("/emergency", function (req, res) {
    const sessionCookie = req.cookies.session || "";
  
    admin
      .auth()
      .verifySessionCookie(sessionCookie, true /** checkRevoked */)
      .then(() => {
        res.render("tables.html");
      })
      .catch((error) => {
        res.redirect("/login");
      });
  });
  
  userRouter.post("/sessionLogin", (req, res) => {
    const idToken = req.body.idToken.toString();
  
    const expiresIn = 60 * 60 * 24 * 5 * 1000;
  
    admin
      .auth()
      .createSessionCookie(idToken, { expiresIn })
      .then(
        (sessionCookie) => {
          const options = { maxAge: expiresIn, httpOnly: true };
          res.cookie("session", sessionCookie, options);
          res.end(JSON.stringify({ status: "success" }));
        },
        (error) => {
          res.status(401).send("UNAUTHORIZED REQUEST!");
        }
      );
  });
  
  userRouter.get("/sessionLogout", (req, res) => {
    res.clearCookie("session");
    res.redirect("/login");
  });

  module.exports = userRouter;