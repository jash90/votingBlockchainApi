var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");



  router.post("/", (req, res) => {
    var answerId = req.body.answerId;
    var token = req.body.token;
    db.auth(token).then(response => {
    var userId = response.data.userId;
      if (response.status == 200) {
        db.query(
          `INSERT INTO public."answerUser" ("answerId", "userId") VALUES ($1, $2);`,
          [answerId, userId]
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

module.exports = router;
