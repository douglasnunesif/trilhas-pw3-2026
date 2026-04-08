const mysql = require("mysql2");

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "ifsuldeminas",
    database: "ecommerce"
})

exports.findByEmail = (email,callback) =>{
    const sql = "SELECT * from users WHERE email = ?";
    db.query(sql, [email], (err, result)=> {
        if(err) throw err
        callback(result[0]);
    })

}