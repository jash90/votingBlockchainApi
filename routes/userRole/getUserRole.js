var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

router.get("/", (req, res) => {
  db
    .query(`SELECT *
	FROM public."userRole";`)
    .then(data => {
      res.json({data: data.rows, status: status.OK.code, message: status.OK.message});
    })
    .catch(error2 => {
      res.json({status: status.Error.code, message: error2.detail});
    });
});

module.exports = router;
