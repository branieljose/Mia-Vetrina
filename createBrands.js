var fs = require('fs');
var path = require('path');
var del = require('delete');
var mysql = require("mysql");
var PORT = process.env.PORT || 3306;

// Global variables
var brandName = process.argv[2];
var filePath  = process.argv[3]; 
var brand_id  = 0; 
var pixelUom  = 0;
var sqlString = '';  

if(process.env.JAWSDB_URL){
  connection = mysql.createConnection(process.env.JAWSDB_URL);
} else {
  	var connection = mysql.createConnection({
  		host: "localhost",
  		user: "root",
  		password: "root",
  		port: PORT,
  		database: "impulso_db"
  });
};
// Make connection.
connection.connect();

// Get Brand ID
//function getBrandId(table, condition, cb){
//	var work = 0; 
//    var queryString = "SELECT * FROM " + table;
//    queryString += " WHERE ";
//    queryString += condition;
//     console.log(queryString); 
//     connection.query(queryString, function(err, data) {
//     	if (err) {
//         	throw err;
//       	}
//      	cb(data);
//     });       	
// }
function getBrandId(sqlString, cb){
    console.log(sqlString); 
    connection.query(sqlString, function(err, data) {
    	if (err) {
        	throw err;
      	}
     	cb(data);
    });       	
}

// Get Pixel Size Uom
function getPixelUom(queryString, cb){
    console.log(sqlString); 
    connection.query(sqlString, function(err, data) {
    	if (err) {
        	throw err;
      	}
     	cb(data);
    });       	
}

// Read & load directory
function loadDirectory(brandName, filePath){
	fs.readdir(filePath,function(err,files){
		if (err) throw err;

		var brandAdds = filePath + brandName + 'Adds.sql'; 
		del.sync(brandAdds);

		var objectAdds = filePath + brandName + 'Objs.sql';
		del.sync(objectAdds); 

		// Open write stream 
		var furnitureStream = fs.createWriteStream(brandAdds, {
			flags: 'a'
		});

		var objectStream = fs.createWriteStream(objectAdds, {
			flags: 'a'
		}); 

		// Write each file 
		files.forEach(function (name) {
			var fileName = name;				
			var fullFile = path.join(filePath, fileName);
			var object   = path.parse(fullFile);			
			var oFil     = object.name;		
			var oExt     = object.ext;		
			// Files only  
			var stat     = fs.statSync(fullFile); 
			if (stat.isFile()) {
				if ((oExt == '.png') || (oExt == '.jpg')) {
					if (fileName.substring(0,3)!='tn_'){				
						var oStr     = oFil.split('_'); 
						var oDir     = object.dir; 	
						var oTyp     = oStr[0];
						var oVue     = oStr[1];
						var oWrk	 = oStr[2];
						var oDim     = oWrk.split('x');
						var oHgt     = oDim[0];
						var oWid     = oDim[1];  
						if (oStr.length == 4){
							var oNam = oStr[3]; 
						} else {
							oNam = ' '; 
						}				
						furnitureStream.write('insert into furniture (brand_id,category_id,furniture_name,real_height,real_width,pixel_height,pixel_width,resolution,click_rate,file_path,file_name)' + '\n'); 
						furnitureStream.write("VALUES (" + brand_id + ",0,'" + oFil + "'," + oHgt + ',' + oWid + ',' + 
							                      oHgt*pixelUom + ',' + oWid*pixelUom + ",72,0,'/app/Media/Furniture/','" + fileName + "');" + '\n'); 
						objectStream.write('insert into objects (obj_name,obj_type_id,furniture_id,real_height,real_width,pixel_height,pixel_width,resolution,static,useradd,user_id,file_path,file_name)' + '\n'); 
						objectStream.write("VALUES ('" + oFil + "',4,null," + oHgt + ',' + oWid + ',' + 
							                      oHgt*pixelUom + ',' + oWid*pixelUom + ",72,0,0,null,'/app/Media/Furniture/','" + fileName + "');" + '\n'); 

		            }          													
				}
			}
		});
		furnitureStream.end();
		objectStream.end(); 
	}); 
}

// Get Brand_Id
//var table     = 'furniture_brand';
//var condition = 'brand like ' + "'" + brandName + "'";
sqlString = 'select * from furniture_brand where brand like ' + "'" + brandName + "'"; 
//getBrandId(table, condition, function(data) {
getBrandId(sqlString, function(data) {	
	brand_id = data[0].id; 
	sqlString = 'select canvas_name,canvas_size_id,pixel_uom from canvas c left join sizes s on c.canvas_size_id=s.id'; 
	getPixelUom(sqlString, function(data) {
		pixelUom = data[0].pixel_uom; 
		loadDirectory(brandName, filePath); 
		connection.end(); 
		console.log(brand_id);
		console.log(pixelUom);  
		console.log('Done!');		
	})
}); 





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


