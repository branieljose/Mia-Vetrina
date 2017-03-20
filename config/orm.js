// Import MySQL connection.
var connection = require("./connection.js");

// Helper function for SQL syntax.
function printQuestionMarks(num) {
  var arr = [];

  for (var i = 0; i < num; i++) {
    arr.push("?");
  }

  return arr.toString();
}

// Helper function for SQL syntax.
function objToSql(ob) {
  var arr = [];

  for (var key in ob) {
    if (Object.hasOwnProperty.call(ob, key)) {
      arr.push(key + "=" + ob[key]);
    }
  }

  return arr.toString();
}

// Object for all our SQL statement functions.
var orm = {

  allAndJoin: function(tableOne, tableTwo, tableOneJoinId, tableTwoJoinId, cb){
    var queryString = "SELECT * FROM " + tableOne;
    queryString += " LEFT JOIN " + tableTwo;
    queryString += " ON " + tableOne + "." + tableOneJoinId;
    queryString += "=" + tableTwo + "." + tableTwoJoinId;
    connection.query(queryString, function(err, result) {
      if (err) {
        throw err;
      }
      cb(result);
    });
  },
  selectAndJoin: function(tableOne, tableTwo, tableOneJoinId, tableTwoJoinId, tableOneJoinIdValue, cb){
    var queryString = "SELECT * FROM " + tableOne;
    queryString += " LEFT JOIN " + tableTwo;
    queryString += " ON " + tableOne + "." + tableOneJoinId;
    queryString += "=" + tableTwo + "." + tableTwoJoinId;
    queryString += " WHERE " + tableOne + "." + tableOneJoinId + '=' + tableOneJoinIdValue; 
    connection.query(queryString, function(err, result) {
      if (err) {
        throw err;
      }
      cb(result);
    });
  },  
  all: function(table, cb) {
    var queryString = "SELECT * FROM " + table + ";";
    connection.query(queryString, function(err, result) {
      if (err) {
        throw err;
      }
      cb(result);
    });
  },
  some: function(table, condition, cb) {
    var queryString = "SELECT * FROM " + table;
    queryString += " WHERE ";
    queryString += condition;
    console.log(queryString); 
    connection.query(queryString, function(err, result) {
      if (err) {
        throw err;
      }
      cb(result);
    });
  },
  last: function(table, cb) {
    var queryString = "SELECT id FROM " + table;
    queryString += " ORDER BY id DESC LIMIT 1";
    console.log(queryString); 
    connection.query(queryString, function(err, result) {
      if (err) {
        throw err;
      }
      cb(result);
    });
  },  
  create: function(table, cols, vals, cb) {
    var queryString = "INSERT INTO " + table;

    queryString += " (";
    queryString += cols.toString();
    queryString += ") ";
    queryString += "VALUES (";
    queryString += printQuestionMarks(vals.length);
    queryString += ") ";

    console.log(queryString);

    connection.query(queryString, vals, function(err, result) {
      if (err) {
        throw err;
      }
      cb(result);
    });
  },
  // An example of objColVals would be {name: panther, sleepy: true}
  update: function(table, objColVals, condition, cb) {
    var queryString = "UPDATE " + table;

    queryString += " SET ";
    queryString += objToSql(objColVals);
    queryString += " WHERE ";
    queryString += condition;

    console.log(queryString);
    connection.query(queryString, function(err, result) {
      if (err) {
        throw err;
      }

      cb(result);
    });
  },
  delete: function(table, condition, cb) {
    var queryString = "DELETE FROM " + table;
    queryString += " WHERE ";
    queryString += condition;

    connection.query(queryString, function(err, result) {
      if (err) {
        throw err;
      }

      cb(result);
    });
  }
};

// Export the orm object for the model (cat.js).
module.exports = orm;