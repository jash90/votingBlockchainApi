var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

router.post("/", (req, res) => {
    var token = req.body.token;
    db
        .auth(token)
        .then(response => {
            if (response.status == 200) {
                var userRoleId = response.data.userRoleId;
                var userId = response.data.userId;
                db.query(`select "question"."name","answer"."name", "answer"."date","question"."publicatedDate", "question"."publicatedDateEnd"
                    from "answerUser"
                    join "answer" on "answer"."id" = "answerUser"."answerId"
                    right join "question" on "question"."id" = "answer"."questionId"
                    where ("answerUser"."userId" = $1 OR "answerUser"."userId" IS NULL )AND "question"."userRoleId"=$2`, [userRoleId, userId])
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
