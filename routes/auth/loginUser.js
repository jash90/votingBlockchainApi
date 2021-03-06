var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

const crypto = require("crypto-js");

router.post("/", function (req, res) {
  var user = req.body.username;
  var pass = req.body.password;

  pass = crypto
    .SHA256(pass)
    .toString(crypto.enc.Hex);

  db
    .query(`SELECT "user"."id", "user"."userRoleId" FROM "user" join "userRole" on "userRole"."id" = "user"."userRoleId"
where "userRole"."login" = true and "user"."login" = $1 AND "user"."password" = $2`, [user, pass])
    .then(data => {
      if (data.rowCount == 1) {
        var user = data.rows[0];
        db
          .query('Select * FROM "token" where "userId" = $1', [user.id])
          .then(data2 => {
            if (data2.rowCount == 1) {
              var token = data2.rows[0];
              res.json({
                data: {
                  userRoleId: user.userRoleId,
                  token: token.token
                },
                status: status.OK.code,
                message: status.OK.message
              });
            } else if (data2.rowCount == 0) {
              token = crypto
                .SHA256(user + new Date().toString())
                .toString(crypto.enc.Hex);
              db
                .query(`INSERT INTO public.token( "userId", token) VALUES ( $1, $2);`, [user.id, token])
                .then(data => {
                  res.json({
                    data: {
                      userRoleId: user.userRoleId,
                      token: token
                    },
                    status: status.OK.code,
                    message: status.OK.message
                  });
                })
                .catch(error => res.json({status: 500, message: error.detail}));
            } else {
              res.json({status: status.Error.code, message: status.Error.message});
            }
          })
          .catch(error => {
            res.json({status: 500, message: status.Error.message});
          });
      } else {
        res
          .status(200)
          .json({status: status.DeniedLogin.code, message: status.DeniedLogin.message});
      }
    })
    .catch(error => {
      res.json({status: status.Error.code, message: error});
    });
});

module.exports = router;
