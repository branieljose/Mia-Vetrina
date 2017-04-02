var express = require("express");
var bodyParser = require("body-parser");
var path = require("path");

var router = express.Router();

// Import the model (cat.js) to use its database functions.
var showroom = require('../models/showroom.js');
var layer = require('../models/layer.js');
var canvas = require('../models/canvas.js');

var layers = [];

// Create all our routes and set up logic within those routes where required.
router.get("/user/:id", function (req, res) {
	showroom.some("user_id=" + [req.params.id], function (data) {
		res.send(data);
	});
});

router.get("/canvas/:id", function (req, res) {
	canvas.some("id=" + [req.params.id], function (data) {
		res.send(data);
	});
});

router.get("/showroom/:id", function (req, res) {
	showroom.selectAndJoin("layers", "id", "showroom_id", [req.params.id], function (data) {
		res.send(data);
	});
});

router.post("/create_showroom", function (req, res) {
	var cols = ['showroom_height', 'showroom_width', 'showroom_name', 
				'canvas_id', 'file_path', 'file_name', 'user_id'];
	var vals = [parseInt(req.body.showroom_height), parseInt(req.body.showroom_width), 
				req.body.showroom_name, parseInt(req.body.canvas_id),
				req.body.file_path, req.body.file_name, parseInt(req.body.user_id)];
	var data = {
		status_code: "",
		showroom_id: 0
	};
console.log(req.body);
console.log(req.body.showroom_name);
console.log(req.body.user_id);
	showroom.create(cols, vals, function (response) {
		data.showroom_id = response.insertId; //only way to get id of an insert for the mysql npm package
		if (response) {
			data.status_code = "OK"
		} else data.status_code = "ERROR"

		res.send(data)

	});
});

router.post("/create_layer", function (req, res) {
	var data = {
		status_code: "",
		layer_id: 0
	};

	console.log(req.body);

	var cols = ['layer_index', 'height', 'width', 'position_top',
				'position_left', 'color', 'opacity', 'layer_type', 
				'object_id', 'showroom_id'];
	var vals = [parseInt(req.body.layer_index), 
				parseInt(req.body.height), parseInt(req.body.width),
				parseInt(req.body.position_top), parseInt(req.body.position_left),
				req.body.color, parseInt(req.body.opacity), req.body.object_type,
				parseInt(req.body.object_id), parseInt(req.body.showroom_id)];

	layer.create(cols, vals, function (response) {
		data.layer_id = response.insertId; //only way to get id of an insert for the mysql npm package
		if (response) {
			data.status_code = "OK"
		} else data.status_code = "ERROR"

		res.send(data)


	});
});

router.delete("/delete_layers/:id", function (req, res) {

	console.log(req.params);

	layer.delete("showroom_id=" + [req.params.id], function (data) {
		res.send(data);
	});
});


// Export routes for server.js to use.
module.exports = router;