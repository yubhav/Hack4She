const express = require('express');
const userRouter = express.Router();

var admin = require("firebase-admin");

var serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://hackforshe2020.firebaseio.com"
});

const db = admin.database();

userRouter.get('/lala', (req, res) => {
    db.ref('help').once('value', (snapshot) => {
       data = snapshot.val();
       console.log("hahaha",data)
       res.json({maindata: data})
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