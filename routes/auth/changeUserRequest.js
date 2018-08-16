var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

const crypto = require("crypto-js");

router.post("/", (req, res) => {
  var Id = req.body.Id;
  var requestId = null;
  var userRoleId = req.body.userRoleId;
  var token = req.body.token;
  db.auth(token).then(response => {
    if (response.status == 200 && response.data.userRoleId == 1) {
      if (Number(userRoleId) == 0) {
        db.query(
          `delete from public."user"
	WHERE "Id" = $1`,
          [Id]
        )
          .then(data => {
            res.json({
              status: status.OK.code,
              message: status.OK.message
            });
          })
          .catch(error2 => {
            res.json({ status: status.Error.code, message: error2.detail });
          });
      } else {
        db.query(
          `UPDATE public."user"
	SET "userRoleId"=$2, "requestId"=$3 
	WHERE "Id" = $1`,
          [Id, userRoleId, requestId]
        )
          .then(data2 => {
            res.json({
              status: status.OK.code,
              message: status.OK.message
            });
          })
          .catch(error2 => {
            res.json({ status: status.Error.code, message: error2.detail });
          });
      }
    } else {
      res.json({
        status: status.Unauthorized.code,
        message: status.Unauthorized.message
      });
    }
  });
});

module.exports = router;
