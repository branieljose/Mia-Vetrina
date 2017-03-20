//getting npm packages ready
var express = require('express');
var bodyParser = require("body-parser");
var path = require("path");
var bcrypt = require('bcryptjs');
var mysql = require('mysql');

var user = require("../models/user.js");

//setting up router for implementation
var router = express.Router();

// var connection = mysql.createConnection({
// 	host: "localhost",
// 	user: "root",
// 	password: "root",
// 	port: 3306,
// 	database: "impulso_db"
// });


//setting up the packages to be used by express 
router.use(bodyParser.json());
router.use(bodyParser.urlencoded({
	extended: true
}));
router.use(bodyParser.text());
router.use(bodyParser.json({
	type: "application/vnd.api+json"
}));


//
router.get("/", function (request, response) {
	response.sendFile(path.join(__dirname, "../public/app/signin.html"));

});

router.get('/sign_out', function(req,res) {
  req.session.destroy(function(err) {
     res.send(true)
  });
});



router.post('/user_login', function (req, res) {

	user.some("user_name=" + JSON.stringify(req.body.user_name), function (data) {

		if (data.length == 0) {
			console.log("INVALID USERNAME")
			
			req.session.status_code = 104;
			req.session.logged_in = false;
			res.send(req.session)
			// res.sendStatus(req.session);
		} else {
			bcrypt.compare(req.body.password_hash, data[0].password_hash, function (err, result) {
				console.log(req.body.password_hash);
				console.log(result);

				if (result == true) {
					console.log("LOGGED IN SUCCESSFULLY");
					req.session.logged_in = true;
					req.session.user_id = data[0].id;
					req.session.user_name = data[0].user_name;
					req.session.first_name = data[0].first_name;
					req.session.last_name = data[0].last_name;
					req.session.email = data[0].email;
					req.session.status_code = 106;
					res.send(req.session);
				} else {
					console.log("WRONG PASSWORD");
					req.session.status_code = 103;
					req.session.logged_in = false;
					res.send(req.session)
				}
			})
		}
	});

});

router.post('/user_signup', function (req, res) {

	user.some("user_name=" + JSON.stringify(req.body.username), function (data) {
		if (data.length == 0) {
			user.some("email=" + JSON.stringify(req.body.email), function (data) {
				if (data.length == 0) {
					bcrypt.genSalt(10, function (err, salt) {
						bcrypt.hash(req.body.password_hash, salt, function (err, hash) {

							user.create("user_name, first_name, last_name, email, password_hash", [req.body.username, req.body.first_name, req.body.last_name, req.body.email, hash], function (data) {

								req.session.user_id = data.insertId; //only way to get id of an insert for the mysql npm package
								console.log("session: " + req.session.user_id + ", data: " + data.insertId);
								// var query = "SELECT * FROM users WHERE id = ?"
								user.some("id=" + [req.session.user_id], function (data) {
									req.session.logged_in = true;
									req.session.user_id = data[0].id;
									req.session.user_name = data[0].username;
									req.session.first_name = data[0].first_name;
									req.session.last_name = data[0].last_name;
									req.session.email = data[0].email;
									req.session.status_code = 105;
									res.send(req.session);
								});


							});

						})
					})
				} else {
					console.log("EMAIL ALREADY EXIST")
					req.session.status_code = 101;
					req.session.logged_in = false;
					res.send(req.session)
				}
			});

		} else {
			console.log("USERNAME NOT AVAILABLE")
			req.session.status_code = 102;
			req.session.logged_in = false;
			res.send(req.session)
		}
	});
});


module.exports = router;