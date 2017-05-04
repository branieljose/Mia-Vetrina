var express = require("express");
var bodyParser = require("body-parser");
var path = require("path");

var router = express.Router();

// Import the model (cat.js) to use its database functions.
var category = require('../models/category.js');

// Create all our routes and set up logic within those routes where required.
router.get("/", function(req, res) {
	category.all(function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/category/:id", function(req, res) {
	category.some("id=" + [req.params.id], function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.post("/create_category", function(req, res){
	var cols = ['category','furniture_type'];
	var vals = [req.body.category, req.body.furniture_type];

	category.create(cols, vals, function(response){
	});
});

router.post("/delete_category", function(req, res){
	// condition will be 'id = x'
	category.delete(condition, function(response){
		res.redirect('/');
	});
});


// Export routes for server.js to use.
module.exports = router;