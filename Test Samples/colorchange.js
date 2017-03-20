var Jimp = require("jimp");

// open a file called "lenna.png" 
Jimp.read("lounger01.png", function (err, lounger01) {
    if (err) throw err;
    lounger01.resize(400, 300)            // resize 
         .quality(72);                     // set JPEG quality 

    var hex = lounger01.getPixelColor(0,0); 
    // {255, 255, 255, 0}
    console.log(Jimp.intToRGBA(hex)); 

    hex = lounger01.getPixelColor(330,210);
    var rgb = Jimp.intToRGBA(hex); 
    console.log(rgb); 

    var color = Jimp.rgbaToInt(214, 178, 150, 255);       

    for (var i=0; i<400; i++) {
    	for (var j=0; j<100; j++){
    		lounger01.setPixelColor(959697, i, j); 
    	}
    	for (var j=101; j<200; j++){
    		lounger01.setPixelColor(color, i, j); 
    	}
    }     
       	   
    lounger01.write("lounger01-small.jpg"); // save 
});