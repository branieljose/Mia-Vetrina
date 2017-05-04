var express = require("express");
var Jimp = require("jimp");
var fs = require('fs');
var path = require('path');

var orm = require('./config/orm.js'); 

// Global variables
var brandName = process.argv[2];
var filePath  = process.argv[3]; 
var items     = []; 

var brand_id  = 0; 

// Get Brand_ID from brand name.
function getBrandId (brandName){
	var work = ''; 
	orm.some('furniture_brand',"brand like '" + brandName + "'", function(data){
		work = data[0].id; 
	});	
	console.log(work); 
	return work; 
}

// Read & load directory
// function writeBrandListRows(brand_id, filePath){
// 	fs.readfile(filePath + brandName + '.txt',function(err,files){
// 		if (err) throw err;

// 		// Open write stream 
// 		var stream = fs.createWriteStream(brandName + '/' + brand + '.txt', {
// 			flags: 'a'
// 		});

// 		//stream.once('open', function(fd){
// 		// Write each file 
// 		files.forEach(function (name) {
// 			var fileName = name;				
// 			var fullFile = path.join(filePath, fileName); 
// 			var object   = path.parse(fullFile);
// 			var oFil     = object.name;
// 			var oStr     = oFil.split('_');  
// 			var oExt     = object.ext;
// 			var oDir     = object.dir; 	
// 			var oTyp     = oStr[0];
// 			var oVue     = oStr[1];
// 			var oWrk	 = oStr[2]; 
// 			if (oStr.length == 4){
// 				var oNam = oStr[3]; 
// 			} else {
// 				oNam = ' '; 
// 			}
// 			var stat     = fs.statSync(fullFile); 
// 			if (stat.isFile()) {
// 				if ((oExt == '.png') || (oExt == '.jpg')) {
// 					j++; 
// 					items[j] = fileName;
// 					stream.write(brand + ',' + oTyp + ',' +
// 								 oVue + ',' + oWrk + ',' +
// 								 filePath + ',' + fileName + '\n');														
// 				}
// 			}
// 		});
// 		stream.end(); 
// 	}); 
// }

brand_id = getBrandId(brandName); 
console.log(brand_id);

//writeBrandListRows(brand, filePath);

// orm.some('objects','obj_type_id=5',function(data){
// 	console.log(data); 
// }); 


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


