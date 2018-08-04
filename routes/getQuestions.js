var router = require("express").Router();

const db = require("../db");
const status = require("../status");

const crypto = require("crypto-js");

router.post("/", (req, res) => {
    var token = req.body.token;

    db.query('Select * FROM "token" where "token" = $1', [token])
      .then((data)=> {
        if (data.rowCount == 1)
        {
            db.query('Select * FROM "question"')
                .then((data2) => {
                    res.json({ data: data2,status: status.Ok.code, message: status.Ok.code });
                })
                .catch((error) => {
                    res.json({ status: status.Error.code, message: error });
                })
        }
        else
        {
            res.json({ status: status.Unauthorized.code, message: status.Unauthorized.message });
        }
      })
      .catch(error => {
        res.json({ status: status.Error.code, message: error });
      });
});

module.exports = router;
