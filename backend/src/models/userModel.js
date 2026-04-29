const mysql = require("mysql2");

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "ifsuldeminas",
  database: "ecommerce",
});

exports.createUser = (user, callback) => {
  const sql =
    "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
  db.query(sql, [user.name, user.email, user.password, user.role], callback);
};

exports.update = (email, user, callback) => {
  const sql = "UPDATE users SET name=?, email=?, password=? WHERE email=?";
  db.query(sql, [user.name, user.email, user.password, email], callback);
};

exports.delete = (email, callback) => {
  db.query("DELETE FROM users WHERE email=?", [email], callback);
};

exports.findByEmail = (email, callback) => {
  const sql = "SELECT * from users WHERE email = ?";
  db.query(sql, [email], (err, result) => {
    if (err) throw err;
    callback(result[0]);
  });
};
