var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var session = require('express-session');
var methodOverride = require('method-override');

var PORT = process.env.PORT || 3000

var app = express();

// Serve static content for the app from the "public" directory in the application directory.
//Vinny put this back, needed to serve index.html content
//app.use(express.static(process.cwd() + "/public/app"));


var cookieParser = require('cookie-parser');

var session = require('express-session');
//allow sessions
app.use(session({ secret: '/', cookie: { maxAge: 14400000 }}));
app.use(cookieParser());

//Vinny commented out, conflicts with index.html
//app.use(express.static(process.cwd() + "/public/app"));
app.use(express.static(process.cwd() + "/public"));

app.use(methodOverride("_method"));

app.use(bodyParser.urlencoded({ extended: false }));

var objectsController   = require("./controllers/objectsController.js");
var palettesController  = require("./controllers/palettesController.js");
var showroomsController = require("./controllers/showroomsController.js");
var signupController    = require("./controllers/signupController.js");
var passresetController = require("./controllers/passresetController.js");

app.get('/about', function(req, res){
  res.sendFile(path.join(__dirname, "./public/about.html"));
})

app.get('/contact', function(req, res){
  res.sendFile(path.join(__dirname, "./public/contact.html"));
})

app.get('', function(req, res){
  res.sendFile(path.join(__dirname, "./public/index.html"));
})

app.use("/objects", objectsController);
app.use("/palettes", palettesController);
app.use("/showrooms", showroomsController);
app.use("/login", signupController);
app.use("/passreset", passresetController);


app.listen(PORT, function() {
    console.log('listening on port ' + PORT)

});



/* ===========================================================
          SOCKET.IO SERVER
=============================================================*/

var io  = require('socket.io').listen(5001),
    dl = require('delivery'),
    fs  = require('fs');

io.sockets.on('connection', function(socket){
  delivery = dl.listen(socket);
  delivery.on('receive.success',function(file){

    fs.writeFile(file.name,file.buffer, function(err){
      if(err){
        console.log('File could not be saved.');
      }else{
        console.log('File saved.');
      };
    });
  });
});