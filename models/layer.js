// Import the ORM to create functions that will interact with the database.
var orm = require("../config/orm.js");

var layer = {
  allAndJoin: function(tableTwo, tableOneJoinId, tableTwoJoinId, cb) {
    orm.allAndJoin("layers", tableTwo, tableOneJoinId, tableTwoJoinId, function(res){
      cb(res);
    });
  },
  selectAndJoin: function(tableTwo, tableOneJoinId, tableTwoJoinId, tableOneJoinIdValue, cb) {
    orm.selectAndJoin("layers", tableTwo, tableOneJoinId, tableTwoJoinId, tableOneJoinIdValue, function(res){
      cb(res);
    });
  },    
  all: function(cb) {
    orm.all("layers", function(res) {
      cb(res);
    });
  },
  some: function(condition, cb) {
    orm.some("layers", condition, function(res) {
      cb(res);
    });
  },  
  // The variables cols and vals are arrays.
  create: function(cols, vals, cb) {
    orm.create("layers", cols, vals, function(res) {
      cb(res);
    });
  },
  update: function(objColVals, condition, cb) {
    orm.update("layers", objColVals, condition, function(res) {
      cb(res);
    });
  },
  delete: function(condition, cb) {
    orm.delete("layers", condition, function(res) {
      cb(res);
    });
  }
};

// Export the database functions for the controller (layersController.js).
module.exports = layer;