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
console.log('Done!');  


