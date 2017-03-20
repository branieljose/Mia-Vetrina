//getting npm packages ready
const express = require('express');
const bodyParser = require("body-parser");
const path = require("path");


//setting up router for implementation
const router = express.Router();



//setting up the packages to be used by express 
router.use(bodyParser.json());
router.use(bodyParser.urlencoded({ extended: true }));
router.use(bodyParser.text());
router.use(bodyParser.json({ type: "application/vnd.api+json" }));

//
router.get("/", function(request, response) {
    response.sendFile(path.join(__dirname, "../public/app/index.html"));
 
});



module.exports = router;