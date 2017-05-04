var express = require("express");
var ase = require('ase-utils');
var cmykRgb = require('cmyk-rgb'); 
var fs = require('fs');
var convert = require('color-convert');

function getPalette(colorTable, format){

	var buffer = fs.readFileSync(colorTable);

	// Input values 
	var output = ase.decode(buffer);
	var groups = output.groups; 
	var colors = output.colors;
	//console.log(colors); 

	var objName    = {}; 
	var stgName    = '';
	var clrPalette = []; 
	var count	   = 0;

	// Read array 
	for (var i=0; i<colors.length; i++){
		if (count < 11) {
			count++;
		    // Get the colors array object 
		    var colorsObj = colors[i];
		    //console.log(colorsObj); 
		    // Load individual elements 
		    var colorName = colorsObj.name; 
		    var colorModel = colorsObj.model;
		    var colorType  = colorsObj.type;
		    console.log('Name   = ' + colorName); 	    
		    console.log('Model  = ' + colorModel);	    
		    console.log('Type   = ' + colorType); 

		    var colorArray = [];
		    var tempArray  = [];
		    var colorHex; 
		    // Parse color array 
		    tempArray = colorsObj.color;
		    console.log('BArray = ' + tempArray); 

		    // CMYK convert to RGB
		    if (colorModel == 'CMYK')
		    	colorArray = cmykRgb(tempArray);
		    else
		    	colorArray = tempArray; 

		    for (var j=0; j<colorArray.length; j++){
		        var value = colorArray[j];
		        // if color is a shade < 1 multiply by 255  
		        if (value<=1){
		            value*=255;
		            colorArray[j]=Math.floor(value);
		        }
		    }

		    console.log('AArray = ' + colorArray);
		    colorHex = convert.rgb.hex(colorArray)
		    console.log('HEX    = ' + colorHex); 

		}

	    var hex = '#'+colorHex;
	    var rgb = colorModel + '(' + colorArray + ')'; 
	    var nam = colorName 

	    // // Build name object 
	    // objName = {name:nam, hex:hex, rgb:rgb};  
	    // //stgName = colorName.replace(/\s/g, '')+','+colorHex + ',' + rgb; 
	    // stgName = "'"+colorName+"'"+',#'+colorHex+','+rgb; 	     
	    // // Load palette array
	    // if (format == 'name')
	    // 	clrPalette.push(nam); 
	    // if (format == 'hex')
	    // 	clrPalette.push(hex);
	    // if (format == 'rgb')
	    // 	clrPalette.push(rgb);
	    // if (format == 'string') 
	    // 	clrPalette.push(stgName);
	    // if (format == 'object')
	    // 	clrPalette.push(objName);
	}
	return clrPalette;	
}

//var colorPalette = './BenjaminMoore_ColorPreview_en-us.ase';
var colorPalette = './PPG_Voice_of_Color.ase';
var format = 'object';
var clrPalette = getPalette(colorPalette,format); 


