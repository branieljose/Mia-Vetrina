var express = require("express");
var Jimp = require("jimp");
var fs = require('fs');
const resizeImg = require('resize-img'); 

// testing Jimp resize, quality and flip 
function modifyImage(image, height, width, resolution, flip, output){

	Jimp.read(image, function (err, image) {
		if (err) throw err;
		image.resize(width, height)
			 .quality(resolution); 

		if (flip === true)
			image.flip(true, false); 

		image.write(output); 
	}); 
}

// testing scale function from Jimp 
function scaleImage(image, factor, output){
	Jimp.read(image, function (err, image) {
		if (err) throw err;
		image.scale(factor) 
			 .write(output);
	})
}


// // testing a different method 
// function sizeImage(img, h, w){
// 	resizeImg(fs.readFileSync(img), {width: w, height: h})
// 		.then(buf => {
// 			fs.writeFileSync("./testImg.png", buf); 
// 	}); 
// }

var image      = './chair_r_30x30.png';
var height     = 30*4; 
var width      = 30*4;
var resolution = 100; 
var factor     = 1.5; 
var flip       = true; 
var output     = './chair_r_30x30_rs.png'; 
modifyImage(image, height, width, resolution, flip, output); 
scaleImage(image, factor, output); 

image      = './full_size_room.jpg';
height     = 768; 
width      = 1152;
resolution = 100; 
factor     = 1.5; 
flip       = false; 
output     = './full_size_room_rs.jpg'; 
modifyImage(image, height, width, resolution, flip, output); 
//scaleImage(image, factor, output); 

// h = 51*4; 
// w = 93*4; 
// img = './chloe_bed_s_51x93.png'; 
// sizeImage(img, h, w);


