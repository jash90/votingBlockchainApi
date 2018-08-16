var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

router.post("/", function(req, res) {
  var router = require("express").Router();

  const db = require("../../db");
  const status = require("../../status");

  const crypto = require("crypto-js");

  router.post("/", (req, res) => {
    var answerId = req.body.answerId;
    var name = req.body.name;
    var questionId = req.body.questionId;
    var token = req.body.token;
    db.auth(token).then(response => {
      if (response.status == 200 && response.data.userRoleId == 2) {
        db.query(
          `UPDATE public."answer"
	name=$1, "questionId"=$2
	WHERE "Id" = $3`,
          [name, questionId, answerId]
        )
          .then(data2 => {
            res.json({
              status: status.OK.code,
              message: status.OK.message
            });
          })
          .catch(error2 => {
            res.json({
              status: status.Error.code,
              message: error2.detail
            });
          });
      } else {
        res.json({
          status: status.Unauthorized.code,
          message: status.Unauthorized.message
        });
      }
    });
  });
});

module.exports = router;
