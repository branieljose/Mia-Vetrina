// Set up MySQL connection.
var mysql = require("mysql");

var PORT = process.env.PORT || 3306;

if(process.env.JAWSDB_URL){
  connection = mysql.createConnection(process.env.JAWSDB_URL);
} else {
  	var connection = mysql.createConnection({
  		host: "localhost",
  		user: "root",
  		password: "",
  		port: 3306,
  		database: "impulso_db"
  });
};
// Make connection.
connection.connect();

// Export connection for our ORM to use.
module.exports = connection;