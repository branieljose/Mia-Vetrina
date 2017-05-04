var express = require("express");
var Jimp = require("jimp");
var fs = require('fs');
var path = require('path');
var del = require('delete');

// Global variables
var filePath  = process.argv[2]; 
var items     = []; 

// testing Jimp resize, quality and flip 
function createThumbNail(fullFile, filePath, fileName){
	Jimp.read(fullFile, function (err, image) {
		if (err) throw err;
		var height = image.bitmap.height;
		var width  = image.bitmap.width; 
		console.log(fileName + ' ' + height + 'x' + width);
		var thumbNail = 'tn_' + fileName;
		var newFile   = path.join(fullFile, thumbNail);
		del.sync(newFile);
		// if (width > height) 
		// 	image.resize(150, 100); 
		// else if (width < height)
		// 	image.resize(100,150);
		// else if (width == height)
		// 	image.resize(150,150);
		image.resize(150, Jimp.AUTO)
		     .quality(80) 
		     .write(filePath + thumbNail); 
	}); 
}

// Read & load directory
function loadDirectory(filePath){
	fs.readdir(filePath,function(err,files){
		if (err) throw err;
		var j = 0; 
		files.forEach(function (name) {
			var fileName  = name;
			var extension = path.extname(fileName); 
			//console.log(filename + ' ' + extension); 			
			var fullFile  = path.join(filePath, fileName); 
			var stat      = fs.statSync(fullFile); 
			if (stat.isFile()) {
				if (fileName.substring(0,3)!='tn_'){
					if ((extension == '.png') || (extension == '.jpg')){
						j++; 
						items[j] = fileName; 
						createThumbNail(fullFile, filePath, fileName);									
					}
				}
			}
		})
	}); 
}

loadDirectory(filePath); 


// //Read itemsArray
// for (var i=0; i<items.length; i++){
// 	// Only process PNG or JPGs. 
// 	createThumbNail(items[i]); 
// }


// var image      = './chair_r_30x30.png';
// var height     = 30*4; 
// var width      = 30*4;
// var resolution = 100; 
// var factor     = 1.5; 
// var flip       = true; 
// var output     = './chair_r_30x30_rs.png'; 
// modifyImage(image, height, width, resolution, flip, output); 
// //scaleImage(image, factor, output); 

// image      = './full_size_room.jpg';
// height     = 768; 
// width      = 1152;
// resolution = 100; 
// factor     = 1.5; 
// flip       = false; 
// output     = './full_size_room_rs.jpg'; 
// modifyImage(image, height, width, resolution, flip, output); 
// //scaleImage(image, factor, output); 

// // h = 51*4; 
// // w = 93*4; 
// // img = './chloe_bed_s_51x93.png'; 
// // sizeImage(img, h, w);


