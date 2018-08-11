const { Pool } = require("pg");
const pool = new Pool({
  user: "admin",
  host: "80.211.222.149",
  database: "votingOnlineDb",
  password: "psB2r#e4",
  port: 5432
});

const status = require("../status");

module.exports = {
  query: (text, params) => pool.query(text, params),
  auth: token =>
    pool
      .query(
        `select "user"."userRoleId", "token", "token"."userId" 
        from "token"
        inner join "user" on "token"."userId" = "user"."Id" where "token" = $1`,
        [token]
      )
      .then(data => {
        if (data.rowCount == 1) {
          return {
            data: data.rows[0],
            status: status.OK.code,
            message: status.OK.message
          };
        } else {
          return {
            status: status.Unauthorized.code,
            message: status.Unauthorized.message
          };
        }
      })
      .catch(error => {
        return { status: status.Error.code, message: error.detail };
      })
};
