// Import the ORM to create functions that will interact with the database.
var orm = require("../config/orm.js");

var brand = {
  allAndJoin: function(tableTwo, tableOneJoinId, tableTwoJoinId, cb) {
    orm.allAndJoin("furniture_brand", tableTwo, tableOneJoinId, tableTwoJoinId, function(res){
      cb(res);
    });
  },
  selectAndJoin: function(tableTwo, tableOneJoinId, tableTwoJoinId, tableOneJoinIdValue, cb) {
    orm.selectAndJoin("furniture_brand", tableTwo, tableOneJoinId, tableTwoJoinId, tableOneJoinIdValue, function(res){
      cb(res);
    });
  },    
  all: function(cb) {
    orm.all("furniture_brand", function(res) {
      cb(res);
    });
  },
  some: function(condition, cb) {
    orm.some("furniture_brand", condition, function(res) {
      cb(res);
    });
  },  
  // The variables cols and vals are arrays.
  create: function(cols, vals, cb) {
    orm.create("furniture_brand", cols, vals, function(res) {
      cb(res);
    });
  },
  update: function(objColVals, condition, cb) {
    orm.update("furniture_brand", objColVals, condition, function(res) {
      cb(res);
    });
  },
  delete: function(condition, cb) {
    orm.delete("furniture_brand", condition, function(res) {
      cb(res);
    });
  }
};

// Export the database functions for the controller (objectsController.js).
module.exports = brand;