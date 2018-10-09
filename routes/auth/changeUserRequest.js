var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

router.post("/", (req, res) => {
  var id = req.body.id;
  var requestId = null;
  var userRoleId = req.body.userRoleId;
  var token = req.body.token;
  db
    .auth(token)
    .then(response => {
      if (response.status == 200 && response.data.userRoleId == 1) {
        if (Number(userRoleId) == 0) {
          db
            .query(`delete from public."user"
	WHERE "id" = $1`, [id])
            .then(data => {
              res.json({status: status.OK.code, message: status.OK.message});
            })
            .catch(error2 => {
              res.json({status: status.Error.code, message: error2.detail});
            });
        } else {
          db
            .query(`UPDATE public."user"
	SET "userRoleId"=$2, "requestId"=$3 
	WHERE "id" = $1`, [Id, userRoleId, requestId])
            .then(data2 => {
              res.json({status: status.OK.code, message: status.OK.message});
            })
            .catch(error2 => {
              res.json({status: status.Error.code, message: error2.detail});
            });
        }
      } else {
        res.json({status: status.Unauthorized.code, message: status.Unauthorized.message});
      }
    });
});

module.exports = router;
