var router = require("express").Router();

const db = require("../db");
const status = require("../status");

// export our router to be mounted by the parent application

// router.post("/", function(req, res) {
//   var user = req.body.username;
//   var pass = req.body.password;
//   console.log([user, pass]);
//   db.query(
//     `INSERT INTO public."user" (login, password, "userRoleId")
// 	VALUES($1, $2, 3);`,
//     [user, pass]
//   )
//     .then(function(data) {
//       res.status(200).json({
//         status: status.OK.code,
//         message: status.OK.message
//       });
//     })
//     .catch(error => {
//       res.json({
//         status: status.Error.code,
//         message: error.detail
//       });
//     });
// });

router.use("/:id/", function (req, res) {
  var user = req.params.id;
  console.log(user);
  db.query(
    `SELECT * FROM "user"`,
  )
    .then(function (data) {
      res.status(200).json({
        status: status.OK.code,
        data:data.rows,
        message: status.OK.message
      });
    })
    .catch(error => {
      res.json({
        status: status.Error.code,
        message: error.detail
      });
    });
});

module.exports = router;
