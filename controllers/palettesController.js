var express = require("express");
var bodyParser = require("body-parser");
var path = require("path");

var router = express.Router();

// Import the model (cat.js) to use its database functions.
var palette = require('../models/palette.js');

function getPalette(colorTable, format){

	// Requires for getPalette function
	var ase = require('ase-utils');
	var cmykRgb = require('cmyk-rgb');
	var fs = require('fs');
	var convert = require('color-convert');

	var buffer = fs.readFileSync(colorTable);

	// Input values 
	var output = ase.decode(buffer); 
	var groups = output.groups; 
	var colors = output.colors;

	var objName    = {}; 
	var stgName    = '';
	var clrPalette = []; 

	// Read array 
	for (var i=0; i<colors.length; i++){
	    // Get the colors array object 
	    var colorsObj = colors[i];
	    // Load individual elements 
	    var colorName = colorsObj.name;  
	    var colorModel = colorsObj.model;
	    var colorType  = colorsObj.type;

	    var tempArray  = [];
	    var colorArray = [];
	    var colorHex;

	    // Parse color array 
	    tempArray = colorsObj.color; 
	    if (colorModel == 'CMYK')
	    	colorArray = cmykRgb(tempArray);
	    if (colorModel == 'RGB')
	    	colorArray = tempArray; 

	    for (var j=0; j<colorArray.length; j++){
	        var value = colorArray[j];
	        // if color is a shade < 1 multiply by 255  
	        if (value<=1){
	            value*=255;
	            colorArray[j]=Math.ceil(value);
	        }
	    }

	    colorHex = convert.rgb.hex(colorArray)
	    var hex = '#'+colorHex;
	    var rgb = colorModel + '(' + colorArray + ')'; 
	    var nam = colorName 

	    // Build name object 
	    objName = {name:nam, hex:hex, rgb:rgb};  
	    //stgName = colorName.replace(/\s/g, '')+','+colorHex + ',' + rgb; 
	    stgName = "'"+colorName+"'"+',#'+colorHex+','+rgb; 	     
	    // Load palette array
	    if (format == 'name')
	    	clrPalette.push(nam); 
	    if (format == 'hex')
	    	clrPalette.push(hex);
	    if (format == 'rgb')
	    	clrPalette.push(rgb);
	    if (format == 'string') 
	    	clrPalette.push(stgName);
	    if (format == 'object')
	    	clrPalette.push(objName);
	}
	return clrPalette;	
}

// Create all our routes and set up logic within those routes where required.
router.get("/", function(req, res) {
	palette.all(function(data){
		res.send(data);
	});	
});

router.get("/palette/:id/:format", function(req, res) {
	palette.some("id=" + [req.params.id], function(data){
		var colorPalette = './public' + data[0].file_path + data[0].file_name;
		var format = [req.params.format]; 
		var clrpalette = getPalette(colorPalette,format);  
		res.send(clrpalette);
	});	
});

router.post("/create_palette", function(req, res){
	var cols = ['palette_name','file_name','file_path'];
	var vals = [req.body.palette_name,req.body.file_name,req.body.file_path];

	palette.create(cols, vals, function(response){
		res.redirect('/');
	});
});

// Export routes for server.js to use.
module.exports = router;