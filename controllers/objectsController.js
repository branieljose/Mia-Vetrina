var express = require("express");
var bodyParser = require("body-parser");
var path = require("path");

var router = express.Router();

// Import the model (cat.js) to use its database functions.
var object = require('../models/object.js');

// Create all our routes and set up logic within those routes where required.
router.get("/", function(req, res) {
	object.all(function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/object/:id", function(req, res) {
	object.some("id=" + [req.params.id], function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/artwork", function(req, res) {
	object.some("obj_type_id=1", function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/decors", function(req, res) {
	object.some("obj_type_id=2", function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/floors", function(req, res) {
	object.some("obj_type_id=3", function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/furniture", function(req, res) {
	object.some("obj_type_id=4", function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/rooms", function(req, res) {
	object.some("obj_type_id=5", function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.get("/textures", function(req, res) {
	object.some("obj_type_id=6", function(data){
		res.send(data);
		//res.send('../public/index', {objects: data});
	});	
});

router.post("/create_object", function(req, res){
	var cols = ['obj_name','obj_type_id','obj_cat_id',
				'height','width','static','useradd',
				'user_id','file_path','file_name'];
	var vals = [req.body.obj_name, req.body.obj_type_id,req.body.obj_cat_id,
				req.body.height,req.body.width,req.body.static,
				req.body.useradd,req.body.user_id,
				req.body.file_path,req.body.file_name];

	object.create(cols, vals, function(response){
	});
});

router.post("/delete_object", function(req, res){
	// condition will be 'id = x'
	object.delete(condition, function(response){
		res.redirect('/');
	});
});


// Export routes for server.js to use.
module.exports = router;