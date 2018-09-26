var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

router.post("/", (req, res) => {
  var token = req.body.token;
  db
    .auth(token)
    .then(response => {
      if (response.status == 200) {
        var userId = response.data.userId;
        db.query('Select * FROM "question" where "createdById" = $1',[userId])
          .then(data2 => {
            res.json({data: data2.rows, status: status.OK.code, message: status.OK.message});
          })
          .catch(error2 => {
            res.json({status: status.Error.code, message: "test"});
          });
      } else {
        res.json({status: status.Unauthorized.code, message: status.Unauthorized.message});
      }
    });
});

module.exports = router;
