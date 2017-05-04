var express = require("express");
var bodyParser = require("body-parser");
var path = require("path");

var router = express.Router();

// Import the model (cat.js) to use its database functions.
var brand = require('../models/brand.js');

// Create all our routes and set up logic within those routes where required.
router.get("/", function(req, res) {
	brand.all(function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/brand/:id", function(req, res) {
	brand.some("id=" + [req.params.id], function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.post("/create_brand", function(req, res){
	var cols = ['brand','file_path','file_name'];
	var vals = [req.body.brand,req.body.file_path,req.body.file_name];

	brand.create(cols, vals, function(response){
	});
});

router.post("/delete_brand", function(req, res){
	// condition will be 'id = x'
	brand.delete(condition, function(response){
		res.redirect('/');
	});
});


// Export routes for server.js to use.
module.exports = router;