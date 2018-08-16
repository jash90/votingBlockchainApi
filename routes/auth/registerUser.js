var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

const crypto = require("crypto-js");

router.post("/", function(req, res) {
  var user = req.body.username;
  var pass = req.body.password;
  var userRoleId = 3;
  if (req.body.userRoleId != undefined) {
    userRoleId = req.body.userRoleId;
  }
  pass = crypto.SHA256(pass).toString(crypto.enc.Hex);
  db.query(
    `select *
from "userRole"
where "Id" = $1 and "register" = true`,
    [userRoleId]
  )
    .then(data => {
      if (data.rowCount == 0) {
        res.status(200).json({
          status: status.Unauthorized.code,
          message: status.Unauthorized.message
        });
      } else {
        db.query(
          `INSERT INTO public."user" (login, password, "userRoleId")
	VALUES($1, $2, $3);`,
          [user, pass, userRoleId]
        )
          .then(data => {
            res.status(200).json({
              status: status.OK.code,
              message: status.OK.message
            });
          })
          .catch(error => {
            res.json({
              status: status.Error.code,
              message: error
            });
          });
      }
    })
    .catch(error => {
      res.json({
        status: status.Error.code,
        message: error
      });
    });
});

module.exports = router;
