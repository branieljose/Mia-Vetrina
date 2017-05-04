var express = require("express");
var bodyParser = require("body-parser");
var Jimp = require("jimp");
var multer  = require('multer');
var storage = multer.memoryStorage();
var upload = multer({ storage: storage });
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
	showroom.create(cols, vals, function (response) {
		data.showroom_id = response.insertId; //only way to get id of an insert for the mysql npm package
		if (response) {
			data.status_code = "OK"
		} else data.status_code = "ERROR"

		res.send(data)

	});
});

router.post("/save_tn/:id", upload.single("blob"),  function (req, res, next) {
	var data = {
		status_code: "",
		tn_name: ""
	};
	var showroom_id = req.params.id;
	var blob;
	var savePath = "./public/app/userShowrooms/";

	var tn_filename = "tn_" + showroom_id +".png";
	savePath += tn_filename;
	data.tn_name = tn_filename
	console.log("path: " + savePath);
	Jimp.read(req.file.buffer, function (err, img) {
		console.log("Success Jimp Read ");
		if (err) console.log("err: " + err);
		img.resize(150, Jimp.AUTO)            // resize 
			.write(savePath); // save 
	});

	if (res) {
		data.status_code = "OK"
	} else data.status_code = "ERROR"

	res.send(data)

});

router.post("/create_layer", function (req, res) {
	var data = {
		status_code: "",
		layer_id: 0
	};

	var flipped;

	if (req.body.flipped == "false") flipped = 0;
	else flipped = 1;

	var cols = ['layer_index', 'height', 'width', 'position_top',
				'position_left', 'angle', 'color', 'opacity', 'layer_type', 
				'object_id', 'flipped', 'showroom_id'];
	var vals = [parseInt(req.body.layer_index), 
				parseInt(req.body.height), parseInt(req.body.width),
				parseInt(req.body.position_top), parseInt(req.body.position_left),
				parseFloat(req.body.angle), req.body.color, parseInt(req.body.opacity), 
				req.body.object_type, parseInt(req.body.object_id), flipped, 
				parseInt(req.body.showroom_id)];

	layer.create(cols, vals, function (response) {
		data.layer_id = response.insertId; //only way to get id of an insert for the mysql npm package
		if (response) {
			data.status_code = "OK"
		} else data.status_code = "ERROR"

		res.send(data)


	});
});

router.put("/update_showroom", function (req, res) {
	var table = "showrooms";
	var colsVals =  {showroom_height: parseInt(req.body.showroom_height), showroom_width: parseInt(req.body.showroom_width)};
	var condition = "id = " + parseInt(req.body.showroom_id);
	var data = {
		status_code: "",
		showroom_id: parseInt(req.body.showroom_id)
	};
	showroom.update(colsVals, condition, function (response) {
		if (response) {
			data.status_code = "OK"
		} else data.status_code = "ERROR"

		res.send(data)

	});
});

router.delete("/delete_layers/:id", function (req, res) {

	layer.delete("showroom_id=" + [req.params.id], function (data) {
		res.send(data);
	});
});

router.delete("/delete_showroom/:id", function (req, res) {

	showroom.delete("id=" + [req.params.id], function (data) {
		res.send(data);
	});
});

// Export routes for server.js to use.
module.exports = router;