var Jimp = require("jimp");
var ase = require('ase-utils');
var fs = require('fs');
var convert = require('color-convert');

var buffer = fs.readFileSync('../Media/Colors/Sherwin_Williams_Colors.ase');
//var output = require('./test.json');

// Input values 
var output = ase.decode(buffer); 
var groups = output.groups; 
var colors = output.colors;

// Output values
var names   = [];
var palette = []; 

//console.log(output);

// Read array 
for (var i=0; i<colors.length; i++){
    // Get the colors array object 
    var colorsObj = colors[i];
    // Load individual elements 
    var colorName = colorsObj.name;  
    var colorModel = colorsObj.model;
    var colorType  = colorsObj.type;

    var colorArray = [];
    var colorHex; 
    // Parse RGB color array 
    colorArray = colorsObj.color; 
    for (var j=0; j<colorArray.length; j++){
        var value = colorArray[j];
        // if color is a shade < 1 multiply by 255  
        if (value<1){
            value*=255;
            colorArray[j]=Math.floor(value);
        }
    }  
    // Get hex value for RGB array
    colorHex = convert.rgb.hex(colorArray[0],colorArray[1],colorArray[2]);   

    // Load names array 
    names.push(colorName.replace(/\s/g, '')+': #'+colorHex);

    // Load palette array
    palette.push(colorModel+'('+colorArray[0]+','+
                                colorArray[1]+','+
                                colorArray[2]+')');

    console.log('Color: ' + colorName + ' , #' + colorHex + ' ,' + 
                            colorModel + '(' + colorArray[0] + ',' + 
                            colorArray[1] + ',' + colorArray[2] + ') ,' + 
                            colorType); 
}
console.log(names); 
console.log(palette);

