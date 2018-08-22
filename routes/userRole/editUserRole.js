var router = require("express").Router();

const db = require("../../db");
const status = require("../../status");

router.post("/", (req, res) => {
    var name = req.body.name;
    var login = req.body.login;
    var register = req.body.register;
    var userRoleId = req.body.userRoleId;
    var token = req.body.token;
    db
        .auth(token)
        .then(response => {
            if (response.status == 200 && response.data.userRoleId == 1) {
                db
                    .query(`UPDATE public."userRole"
	SET name=$1, "login"=$2, "register"=$3
	WHERE "Id" = $4`, [name, login, register, userRoleId])
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
