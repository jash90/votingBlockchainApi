var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

router.post("/", (req, res) => {
  var questionId = req.body.questionId;
  var token = req.body.token;
  db
    .auth(token)
    .then(response => {
      if (response.status == 200) {
        var userId = response.data.userId;
        var userRoleId = response.data.userRoleId;
        db
          .query(`select "question"."name","answer"."name", "answer"."date","question"."publicatedDate", "question"."publicatedDateEnd"
from "answerUser"
join "answer" on "answer"."Id" = "answerUser"."answerId"
join "question" on "question"."Id" = "answer"."questionId"
where "question"."Id" = $1 and ("question"."publicatedDateEnd" < NOW() or "answerUser"."userId" =$2)`, [questionId, userId])
          .then(data2 => {
            if (data2.rowCount == 0) {
              db
                .query(`Select * FROM "answer" where "questionId" = $1 and "userRoleId" = $2`, [questionId, userRoleId])
                .then(data3 => {
                  res.json({data: data3.rows, status: status.OK.code, message: status.OK.message});
                })
                .catch(error3 => {
                  res.json({status: status.Error.code, message: error3.detail});
                });
            } else {
              res.json({data: data2.rows, status: status.OK.code, message: status.OK.message});
            }
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
