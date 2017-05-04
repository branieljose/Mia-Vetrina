// Import the ORM to create functions that will interact with the database.
var orm = require("../config/orm.js");

var furniture = {
  allAndJoin: function(tableTwo, tableOneJoinId, tableTwoJoinId, cb) {
    orm.allAndJoin("furniture", tableTwo, tableOneJoinId, tableTwoJoinId, function(res){
      cb(res);
    });
  },
  selectAndJoin: function(tableTwo, tableOneJoinId, tableTwoJoinId, tableOneJoinIdValue, cb) {
    orm.selectAndJoin("furniture", tableTwo, tableOneJoinId, tableTwoJoinId, tableOneJoinIdValue, function(res){
      cb(res);
    });
  },    
  all: function(cb) {
    orm.all("furniture", function(res) {
      cb(res);
    });
  },
  some: function(condition, cb) {
    orm.some("furniture", condition, function(res) {
      cb(res);
    });
  },  
  // The variables cols and vals are arrays.
  create: function(cols, vals, cb) {
    orm.create("furniture", cols, vals, function(res) {
      cb(res);
    });
  },
  update: function(objColVals, condition, cb) {
    orm.update("furniture", objColVals, condition, function(res) {
      cb(res);
    });
  },
  delete: function(condition, cb) {
    orm.delete("furniture", condition, function(res) {
      cb(res);
    });
  }
};

// Export the database functions for the controller (objectsController.js).
module.exports = furniture;