var express = require("express");
var Jimp = require("jimp");
var fs = require('fs');
var path = require('path');
var del = require('delete');

// var orm = require('../../config/orm.js'); 

// Global variables
var brand     = process.argv[2];
var filePath  = process.argv[3]; 
var items     = []; 

// Read & load directory
function loadDirectory(brand, filePath){
	fs.readdir(filePath,function(err,files){
		if (err) throw err;
		var j = 0; 
		var brandList = filePath + '/' + brand + '.txt'; 
		del.sync(brandList);

		// Open write stream 
		var stream = fs.createWriteStream(brandList, {
			flags: 'a'
		});

		// Write each file 
		files.forEach(function (name) {
			var fileName = name;				
			var fullFile = path.join(filePath, fileName); 
			var object   = path.parse(fullFile);
			var oFil     = object.name;
			var oStr     = oFil.split('_');  
			var oExt     = object.ext;
			var oDir     = object.dir; 	
			var oTyp     = oStr[0];
			var oVue     = oStr[1];
			var oWrk	 = oStr[2]; 
			if (oStr.length == 4){
				var oNam = oStr[3]; 
			} else {
				oNam = ' '; 
			}
			var stat     = fs.statSync(fullFile); 
			if (stat.isFile()) {
				if ((oExt == '.png') || (oExt == '.jpg')) {
					j++; 
					items[j] = fileName;
					stream.write(brand + ',' + oTyp + ',' +
								 oVue + ',' + oWrk + ',' +
								 filePath + ',' + fileName + '\n');														
				}
			}
		});
		stream.end(); 
	}); 
}

loadDirectory(brand, filePath);
console.log('Done!');

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


