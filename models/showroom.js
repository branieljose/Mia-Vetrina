// Import the ORM to create functions that will interact with the database.
var orm = require("../config/orm.js");

var showroom = {
  allAndJoin: function(tableTwo, tableOneJoinId, tableTwoJoinId, cb) {
    orm.allAndJoin("showrooms", tableTwo, tableOneJoinId, tableTwoJoinId, function(res){
      cb(res);
    });
  },
  selectAndJoin: function(tableTwo, tableOneJoinId, tableTwoJoinId, tableOneJoinIdValue, cb) {
    orm.selectAndJoin("showrooms", tableTwo, tableOneJoinId, tableTwoJoinId, tableOneJoinIdValue, function(res){
      cb(res);
    });
  },  
  all: function(cb) {
    orm.all("showrooms", function(res) {
      cb(res);
    });
  },
  some: function(condition, cb) {
    orm.some("showrooms", condition, function(res) {
      cb(res);
    });
  },  
  last: function(cb) {
    orm.last("showrooms", function(res) {
      cb(res);
    });
  },    
  // The variables cols and vals are arrays.
  create: function(cols, vals, cb) {
    orm.create("showrooms", cols, vals, function(res) {
      cb(res);
    });
  },
  update: function(objColVals, condition, cb) {
    orm.update("showrooms", objColVals, condition, function(res) {
      cb(res);
    });
  },
  delete: function(condition, cb) {
    orm.delete("showrooms", condition, function(res) {
      cb(res);
    });
  }
};

// Export the database functions for the controller (roomsController.js).
module.exports = showroom;