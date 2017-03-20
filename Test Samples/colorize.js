var Jimp = require("jimp");
var sizeOf = require('image-size');
var toNumber = require('to-num');

const waitSync = require('wait-sync');

var imgHeight  = 0;
var imgWidth   = 0;
var newHeight  = 0;
var newWidth   = 0;
var wallHeight = 0;
var wallWidth  = 0;
var wallHexClr = 0;
var diffHexClr = 0;
var wallRGBA   = {};
var wallColor  = 0;

var img = 'furnLayer.jpg';
var flp = 'furnLayerA.jpg';

// Get Dimensions of original PNG image 
sizeOf(img, function (err, dimensions) {
    imgWidth  = dimensions.width; 
    imgHeight = dimensions.height;         
});

waitSync(1.0); 
console.log('Original image      = ' + img); 
console.log('Original dimensions = ' + imgWidth + ' by ' + imgHeight + ' (WxH)');   // 800, 480 

// Clone & Resize original image 
function cloneResize(img) {
    Jimp.read(img, function (err, image) {
        if (err) throw err;

        // Clone the image and work with the clone 
        var newImage = image.clone();               

        // Get color of PNG region (0,0) - this is our wall 
        wallHexClr = newImage.getPixelColor(0,0); 
        wallRGBA = Jimp.intToRGBA(wallHexClr); 
        console.log(' ');
        console.log('Resized Wall color = ' + wallHexClr);                 
        wallWidth = imgWidth;     
    }); 
}

function getWallSize(img) {
    //Map out the wall dimensions 
    //0,0 to xxx,xxx 
    Jimp.read(img, function (err, image) {
        if (err) throw err;

        // Clone the image and work with the clone 
        var wallImage = image.clone();           
              
        for (var i=0; i<imgHeight; i++){
            var newHexClr = wallImage.getPixelColor(0,i);
            //var newRGBA = Jimp.intToRGBA(newHexColor);
            //console.log(newHexColor + ' ' + newRGBA); 
            wallHeight = i; 
            if (newHexClr != wallHexClr){
                console.log('getWallSize()'); 
                console.log('i          = ' + i); 
                console.log('WallHexClr =' + wallHexClr); 
                console.log('NewHexClr  =' + newHexClr); 
                console.log(' '); 
                diffHexClr = newHexClr; 
                i = imgHeight; 
            }
        } 
    }); 
    waitSync(1.0); 
    console.log('Wall Width/Height = ' + wallWidth + '/' + wallHeight);     
}

function imgColorize(img){

    wallColor = toNumber('0x9CFFF4'); 
    console.log('New Wall Color = ' + wallColor)

    Jimp.read(img, function (err, image) {
        if (err) throw err;

        // Clone the image and work with the clone 
        var wallImage = image.clone(); 

        for (var i=0; i<wallWidth; i++) {
            for (var j=0; j<wallHeight; j++){
                var newHexClr = wallImage.getPixelColor(i,j);
                if (newHexClr == wallHexClr){
                    wallImage.setPixelColor(wallColor, i, j); 
                }
            }
        }            
        wallImage.write(flp); 
        console.log(wallImage.getPixelColor(799,274))        
    });    
}

cloneResize(img);
waitSync(1.0);
getWallSize(img);
imgColorize(img); 




    // console.log(newImage.getPixelColor(0,1)); 
    // console.log(newImage.getPixelColor(0,100)); 
    // console.log(newImage.getPixelColor(0,479));        
    
 



    // hex = lounger01.getPixelColor(330,210);
    // var rgb = Jimp.intToRGBA(hex); 
    // console.log(rgb); 

    // var color = Jimp.rgbaToInt(214, 178, 150, 255);       

    // for (var i=0; i<400; i++) {
    // 	for (var j=0; j<100; j++){
    // 		lounger01.setPixelColor(959697, i, j); 
    // 	}
    // 	for (var j=101; j<200; j++){
    // 		lounger01.setPixelColor(color, i, j); 
    // 	}
    // }     
       	   
    // lounger01.write("lounger01-small.jpg"); // save 
