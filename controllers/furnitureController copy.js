var express = require("express");
var bodyParser = require("body-parser");
var path = require("path");

var router = express.Router();

// Import the model (cat.js) to use its database functions.
var furniture = require('../models/furniture.js');

// Create all our routes and set up logic within those routes where required.
router.get("/", function(req, res) {
	furniture.all(function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/:id", function(req, res) {
	furniture.some("id=" + [req.params.id], function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/brand/:id", function(req, res) {
	furniture.some("brand_id=" + [req.params.id], function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/category/:id", function(req, res) {
	furniture.some("category_id=" + [req.params.id], function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.post("/create_furniture", function(req, res){
	var cols = ['brand_id','category_id','furniture_name',
				'real_height','real_width','pixel_height','pixel_width',
				'resolution','click_rate','file_path','file_name'];
	var vals = [req.body.brand_id, req.body.category_id,req.body.furniture_name,
				req.body.real_height,req.body.real_width,req.body.pixel_height,
				req.body.pixel_width,req.body.resolution,req.body.click_rate,
				req.body.file_path,req.body.file_name];

	furniture.create(cols, vals, function(response){
	});
});

router.post("/delete_furniture", function(req, res){
	// condition will be 'id = x'
	furniture.delete(condition, function(response){
		res.redirect('/');
	});
});


// Export routes for server.js to use.
module.exports = router;