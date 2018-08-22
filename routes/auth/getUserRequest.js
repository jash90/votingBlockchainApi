var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

router.post("/", (req, res) => {
  var token = req.body.token;
  db
    .auth(token)
    .then(response => {
      if (response.status == 200 && response.data.userRoleId == 1) {
        db
          .query(`select * from public."user" where "requestId" IS NOT NULL`)
          .then(data2 => {
            res.json({data: data2.rows, status: status.OK.code, message: status.OK.message});
          })
          .catch(error2 => {
            res.json({status: status.Error.code, message: error2.detail});
          });
      } else {
        res.json({status: status.Unauthorized.code, message: status.Unauthorized.message});
      }
    });
});

module.exports = router;
