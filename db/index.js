const {Pool} = require('pg')
const pool = new Pool({user: "admin", host: "localhost", database: "votingOnlineDb", password: "admin", port: 5432});

const status = require("../status");

module.exports = {
  query: (text, params) => 
    pool.query(text, params)
  ,
  auth: (token) => 
    pool
      .query('Select * FROM "token" where "token" = $1', [token])
      .then(data =>{
        if (data.rowCount == 1)
        {
          return { data: data.rows[0],status: status.OK.code, message: status.OK.message }
        }
        else
        {
          return { status: status.Unauthorized.code, message: status.Unauthorized.message }
        }
      })
      .catch(error=>{
        return {status : status.Error.code, message:error.detail}
      })
  
}