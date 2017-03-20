// Import the ORM to create functions that will interact with the database.
var orm = require("../config/orm.js");

var object = {
  allAndJoin: function(tableTwo, tableOneJoinId, tableTwoJoinId, cb) {
    orm.allAndJoin("objects", tableTwo, tableOneJoinId, tableTwoJoinId, function(res){
      cb(res);
    });
  },
  selectAndJoin: function(tableTwo, tableOneJoinId, tableTwoJoinId, tableOneJoinIdValue, cb) {
    orm.selectAndJoin("objects", tableTwo, tableOneJoinId, tableTwoJoinId, tableOneJoinIdValue, function(res){
      cb(res);
    });
  },    
  all: function(cb) {
    orm.all("objects", function(res) {
      cb(res);
    });
  },
  some: function(condition, cb) {
    orm.some("objects", condition, function(res) {
      cb(res);
    });
  },  
  // The variables cols and vals are arrays.
  create: function(cols, vals, cb) {
    orm.create("objects", cols, vals, function(res) {
      cb(res);
    });
  },
  update: function(objColVals, condition, cb) {
    orm.update("objects", objColVals, condition, function(res) {
      cb(res);
    });
  },
  delete: function(condition, cb) {
    orm.delete("objects", condition, function(res) {
      cb(res);
    });
  }
};

// Export the database functions for the controller (objectsController.js).
module.exports = object;