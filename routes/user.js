const Router = require("express-promise-router");

const db = require("../db");
const status = require("../status");

const router = new Router();

// export our router to be mounted by the parent application


router.get("/user",function(req, res, next) {
  db.query("SELECT * FROM users").then(function (data) {
    res.status(200)
      .json({
        status:status.OK.code,
        data: data.rows,
        message: status.OK.message
      });
  })
});


module.exports = router
