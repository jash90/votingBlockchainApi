var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

router.post("/", (req, res) => {
  var questionId = req.body.questionId;
  var name = req.body.name;
  var multiAnswer = req.body.multiAnswer;
  var userRoleId = req.body.userRoleId;
  var token = req.body.token;
  db
    .auth(token)
    .then(response => {
      if (response.status == 200 && response.data.userRoleId == 2) {
        db
          .query(`UPDATE public.question
	SET name=$1, "multiAnswer"=$2, "userRoleId"=$3
	WHERE "Id" = $4`, [name, multiAnswer, userRoleId, questionId])
          .then(data2 => {
            res.json({status: status.OK.code, message: status.OK.message});
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
