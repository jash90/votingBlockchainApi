var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

const SQL = 
`
SELECT
    "question"."id" AS "questionId",
    "question"."name" AS "questionName",
    "answer"."id" AS "answerId",
    "answer"."name" AS "answerName",
    "answer"."date" AS "answerDate",
    "question"."publicatedDate",
    "question"."publicatedDateEnd"
FROM
    "answerUser"
    JOIN "answer" ON "answer"."id" = "answerUser"."answerId"
    FULL OUTER JOIN "question" ON "question"."id" = "answer"."questionId"
WHERE
    "question"."userRoleId" = $1
    AND "answerUser"."userId" = $2
    OR "answer"."id" IS NULL
    OR "answer"."name" IS NULL
    OR "answer"."date" IS NULL
ORDER BY
    "question"."publicatedDate",
    "answerUser"."userId"
`;

router.post("/", (req, res) => {
    var token = req.body.token;
    db
        .auth(token)
        .then(response => {
            if (response.status == 200) {
                var userRoleId = response.data.userRoleId;
                var userId = response.data.userId;
                db.query(SQL, [userRoleId, userId])
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
