var express = require("express");
var bodyParser = require("body-parser");
var path = require("path");
var createHash = require("hash-generator");
var bcrypt = require('bcryptjs');
var router = express.Router();

var user = require("../models/user.js");

//checks email, creates and store hash, sends email.
router.post("/", function(req, res) {
  var hash = createHash(20);
  var email = req.body.email;

  user.some("email=" + JSON.stringify(email), function(data) {
      console.log(data[0].first_name);
      var name = data[0].first_name;
      if (Object.keys(data).length == 0) {
          console.log("email not found");
      } else {
          console.log("email found");
          sendEmail(email, hash, name);
          storeHash(email, hash);
      }
  });
});

router.use(express.static(process.cwd() + "./public"));

//checks hash, serves reset pass form
router.get('/36bledv3asa5yw96hnlv/:hash/', function(req, res) {
  var hash = req.params.hash;
  var isNew = req.params.new;
    verifyHash(hash, res);  
    console.log("this is the hash", hash)
});
//checks hash, resets password.
router.put('/36bledv3asa5yw96hnlv/:hash/reset', function(req, res){
  var newPass = req.body.pass
  var hash = req.params.hash;
    resetPass(newPass, hash, res);
    deleteHash(hash);
    console.log(req.body.pass);
});

function resetPass(newPass, passHash, res){
  console.log("resetting password");
  user.some("passResetHash=" + JSON.stringify(passHash), function(data) {
    var id = data[0].id;
    console.log("this is the user's id", data[0].id);
      bcrypt.genSalt(10, function (err, salt) {
      bcrypt.hash(newPass, salt, function (err, hash){
            
            var condition = "id = " + id;

        user.update({ password_hash: JSON.stringify(hash) }, condition, function(data) {
            console.log(data);
            console.log("Password has been updated!");
             res.redirect(303, "/app");
        });
      });
    });
  });
};

function verifyHash(hash, res){
  console.log("it finds the hash")
  user.some("passResetHash=" + JSON.stringify(hash), function(data) {
    if (Object.keys(data).length == 0) {
        res.redirect("/app");
    } else { 
       res.sendFile(path.join(__dirname, "../public/app/recoveryForm.html"));
    }
});
};

function deleteHash(hash) {
  var condition = "passResetHash = " + JSON.stringify(hash);

    user.update({ passResetHash: "NULL" }, condition, function(data) {
        console.log("hash deleted!", data);
    });
};

function storeHash(email, hash) {
  var condition = "email = " + JSON.stringify(email);

    user.update({ passResetHash: JSON.stringify(hash) }, condition, function(data) {
        // console.log("hash saved", data);
    });
};

function sendEmail(email, hash, name) {
  var nodemailer = require('nodemailer');
  var url = "http://localhost:3000/passreset/36bledv3asa5yw96hnlv/"+hash;

  // create reusable transporter object using the default SMTP transport
  var transporter = nodemailer.createTransport({
      service: 'miavetrina',
      auth: {
          user: 'braniel',
          pass: 'Veloster23'
      }
});

// setup email data with unicode symbols
var mailOptions = {
    from: '"Mia Vetrina Team " ', // sender address
    to: email, // list of receivers
    subject: 'Password Reset Requested', // Subject line
    text: '', // plain text body
    html:  '   <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  '  + 
 '   <html xmlns="http://www.w3.org/1999/xhtml">  '  + 
 '     <head>  '  + 
 '       <meta name="viewport" content="width=device-width, initial-scale=1.0" />  '  + 
 '       <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />  '  + 
 '       <title>MIΛ VETRINΛ</title>  '  + 
 '       <!--   '  + 
 '       The style block is collapsed on page load to save you some scrolling.  '  + 
 '       Postmark automatically inlines all CSS properties for maximum email client   '  + 
 '       compatibility. You can just update styles here, and Postmark does the rest.  '  + 
 '       -->  '  + 
 '       <style type="text/css" rel="stylesheet" media="all">  '  + 
 '       /* Base ------------------------------ */  '  + 
 '         '  + 
 '       *:not(br):not(tr):not(html) {  '  + 
 '         font-family: Arial, "Helvetica Neue", Helvetica, sans-serif;  '  + 
 '         box-sizing: border-box;  '  + 
 '       }  '  + 
 '         '  + 
 '       body {  '  + 
 '         width: 100% !important;  '  + 
 '         height: 100%;  '  + 
 '         margin: 0;  '  + 
 '         line-height: 1.4;  '  + 
 '         background-color: #F2F4F6;  '  + 
 '         color: #74787E;  '  + 
 '         -webkit-text-size-adjust: none;  '  + 
 '       }  '  + 
 '         '  + 
 '       p,  '  + 
 '       ul,  '  + 
 '       ol,  '  + 
 '       blockquote {  '  + 
 '         line-height: 1.4;  '  + 
 '         text-align: left;  '  + 
 '       }  '  + 
 '         '  + 
 '       a {  '  + 
 '         color: #3869D4;  '  + 
 '       }  '  + 
 '         '  + 
 '       a img {  '  + 
 '         border: none;  '  + 
 '       }  '  + 
 '         '  + 
 '       td {  '  + 
 '         word-break: break-word;  '  + 
 '       }  '  + 
 '       /* Layout ------------------------------ */  '  + 
 '         '  + 
 '       .email-wrapper {  '  + 
 '         width: 100%;  '  + 
 '         margin: 0;  '  + 
 '         padding: 0;  '  + 
 '         -premailer-width: 100%;  '  + 
 '         -premailer-cellpadding: 0;  '  + 
 '         -premailer-cellspacing: 0;  '  + 
 '         background-color: #F2F4F6;  '  + 
 '       }  '  + 
 '         '  + 
 '       .email-content {  '  + 
 '         width: 100%;  '  + 
 '         margin: 0;  '  + 
 '         padding: 0;  '  + 
 '         -premailer-width: 100%;  '  + 
 '         -premailer-cellpadding: 0;  '  + 
 '         -premailer-cellspacing: 0;  '  + 
 '       }  '  + 
 '       /* Masthead ----------------------- */  '  + 
 '         '  + 
 '       .email-masthead {  '  + 
 '         padding: 25px 0;  '  + 
 '         text-align: center;  '  + 
 '       }  '  + 
 '         '  + 
 '       .email-masthead_logo {  '  + 
 '         width: 94px;  '  + 
 '       }  '  + 
 '         '  + 
 '       .email-masthead_name {  '  + 
 '         font-size: 16px;  '  + 
 '         font-weight: bold;  '  + 
 '         color: #bbbfc3;  '  + 
 '         text-decoration: none;  '  + 
 '         text-shadow: 0 1px 0 white;  '  + 
 '       }  '  + 
 '       /* Body ------------------------------ */  '  + 
 '         '  + 
 '       .email-body {  '  + 
 '         width: 100%;  '  + 
 '         margin: 0;  '  + 
 '         padding: 0;  '  + 
 '         -premailer-width: 100%;  '  + 
 '         -premailer-cellpadding: 0;  '  + 
 '         -premailer-cellspacing: 0;  '  + 
 '         border-top: 1px solid #EDEFF2;  '  + 
 '         border-bottom: 1px solid #EDEFF2;  '  + 
 '         background-color: #FFFFFF;  '  + 
 '       }  '  + 
 '         '  + 
 '       .email-body_inner {  '  + 
 '         width: 570px;  '  + 
 '         margin: 0 auto;  '  + 
 '         padding: 0;  '  + 
 '         -premailer-width: 570px;  '  + 
 '         -premailer-cellpadding: 0;  '  + 
 '         -premailer-cellspacing: 0;  '  + 
 '         background-color: #FFFFFF;  '  + 
 '       }  '  + 
 '         '  + 
 '       .email-footer {  '  + 
 '         width: 570px;  '  + 
 '         margin: 0 auto;  '  + 
 '         padding: 0;  '  + 
 '         -premailer-width: 570px;  '  + 
 '         -premailer-cellpadding: 0;  '  + 
 '         -premailer-cellspacing: 0;  '  + 
 '         text-align: center;  '  + 
 '       }  '  + 
 '         '  + 
 '       .email-footer p {  '  + 
 '         color: #AEAEAE;  '  + 
 '       }  '  + 
 '         '  + 
 '       .body-action {  '  + 
 '         width: 100%;  '  + 
 '         margin: 30px auto;  '  + 
 '         padding: 0;  '  + 
 '         -premailer-width: 100%;  '  + 
 '         -premailer-cellpadding: 0;  '  + 
 '         -premailer-cellspacing: 0;  '  + 
 '         text-align: center;  '  + 
 '       }  '  + 
 '         '  + 
 '       .body-sub {  '  + 
 '         margin-top: 25px;  '  + 
 '         padding-top: 25px;  '  + 
 '         border-top: 1px solid #EDEFF2;  '  + 
 '       }  '  + 
 '         '  + 
 '       .content-cell {  '  + 
 '         padding: 35px;  '  + 
 '       }  '  + 
 '         '  + 
 '       .preheader {  '  + 
 '         display: none !important;  '  + 
 '         visibility: hidden;  '  + 
 '         mso-hide: all;  '  + 
 '         font-size: 1px;  '  + 
 '         line-height: 1px;  '  + 
 '         max-height: 0;  '  + 
 '         max-width: 0;  '  + 
 '         opacity: 0;  '  + 
 '         overflow: hidden;  '  + 
 '       }  '  + 
 '       /* Attribute list ------------------------------ */  '  + 
 '         '  + 
 '       .attributes {  '  + 
 '         margin: 0 0 21px;  '  + 
 '       }  '  + 
 '         '  + 
 '       .attributes_content {  '  + 
 '         background-color: #EDEFF2;  '  + 
 '         padding: 16px;  '  + 
 '       }  '  + 
 '         '  + 
 '       .attributes_item {  '  + 
 '         padding: 0;  '  + 
 '       }  '  + 
 '       /* Related Items ------------------------------ */  '  + 
 '         '  + 
 '       .related {  '  + 
 '         width: 100%;  '  + 
 '         margin: 0;  '  + 
 '         padding: 25px 0 0 0;  '  + 
 '         -premailer-width: 100%;  '  + 
 '         -premailer-cellpadding: 0;  '  + 
 '         -premailer-cellspacing: 0;  '  + 
 '       }  '  + 
 '         '  + 
 '       .related_item {  '  + 
 '         padding: 10px 0;  '  + 
 '         color: #74787E;  '  + 
 '         font-size: 15px;  '  + 
 '         line-height: 18px;  '  + 
 '       }  '  + 
 '         '  + 
 '       .related_item-title {  '  + 
 '         display: block;  '  + 
 '         margin: .5em 0 0;  '  + 
 '       }  '  + 
 '         '  + 
 '       .related_item-thumb {  '  + 
 '         display: block;  '  + 
 '         padding-bottom: 10px;  '  + 
 '       }  '  + 
 '         '  + 
 '       .related_heading {  '  + 
 '         border-top: 1px solid #EDEFF2;  '  + 
 '         text-align: center;  '  + 
 '         padding: 25px 0 10px;  '  + 
 '       }  '  + 
 '       /* Discount Code ------------------------------ */  '  + 
 '         '  + 
 '       .discount {  '  + 
 '         width: 100%;  '  + 
 '         margin: 0;  '  + 
 '         padding: 24px;  '  + 
 '         -premailer-width: 100%;  '  + 
 '         -premailer-cellpadding: 0;  '  + 
 '         -premailer-cellspacing: 0;  '  + 
 '         background-color: #EDEFF2;  '  + 
 '         border: 2px dashed #9BA2AB;  '  + 
 '       }  '  + 
 '         '  + 
 '       .discount_heading {  '  + 
 '         text-align: center;  '  + 
 '       }  '  + 
 '         '  + 
 '       .discount_body {  '  + 
 '         text-align: center;  '  + 
 '         font-size: 15px;  '  + 
 '       }  '  + 
 '       /* Social Icons ------------------------------ */  '  + 
 '         '  + 
 '       .social {  '  + 
 '         width: auto;  '  + 
 '       }  '  + 
 '         '  + 
 '       .social td {  '  + 
 '         padding: 0;  '  + 
 '         width: auto;  '  + 
 '       }  '  + 
 '         '  + 
 '       .social_icon {  '  + 
 '         height: 20px;  '  + 
 '         margin: 0 8px 10px 8px;  '  + 
 '         padding: 0;  '  + 
 '       }  '  + 
 '       /* Data table ------------------------------ */  '  + 
 '         '  + 
 '       .purchase {  '  + 
 '         width: 100%;  '  + 
 '         margin: 0;  '  + 
 '         padding: 35px 0;  '  + 
 '         -premailer-width: 100%;  '  + 
 '         -premailer-cellpadding: 0;  '  + 
 '         -premailer-cellspacing: 0;  '  + 
 '       }  '  + 
 '         '  + 
 '       .purchase_content {  '  + 
 '         width: 100%;  '  + 
 '         margin: 0;  '  + 
 '         padding: 25px 0 0 0;  '  + 
 '         -premailer-width: 100%;  '  + 
 '         -premailer-cellpadding: 0;  '  + 
 '         -premailer-cellspacing: 0;  '  + 
 '       }  '  + 
 '         '  + 
 '       .purchase_item {  '  + 
 '         padding: 10px 0;  '  + 
 '         color: #74787E;  '  + 
 '         font-size: 15px;  '  + 
 '         line-height: 18px;  '  + 
 '       }  '  + 
 '         '  + 
 '       .purchase_heading {  '  + 
 '         padding-bottom: 8px;  '  + 
 '         border-bottom: 1px solid #EDEFF2;  '  + 
 '       }  '  + 
 '         '  + 
 '       .purchase_heading p {  '  + 
 '         margin: 0;  '  + 
 '         color: #9BA2AB;  '  + 
 '         font-size: 12px;  '  + 
 '       }  '  + 
 '         '  + 
 '       .purchase_footer {  '  + 
 '         padding-top: 15px;  '  + 
 '         border-top: 1px solid #EDEFF2;  '  + 
 '       }  '  + 
 '         '  + 
 '       .purchase_total {  '  + 
 '         margin: 0;  '  + 
 '         text-align: right;  '  + 
 '         font-weight: bold;  '  + 
 '         color: #2F3133;  '  + 
 '       }  '  + 
 '         '  + 
 '       .purchase_total--label {  '  + 
 '         padding: 0 15px 0 0;  '  + 
 '       }  '  + 
 '       /* Utilities ------------------------------ */  '  + 
 '         '  + 
 '       .align-right {  '  + 
 '         text-align: right;  '  + 
 '       }  '  + 
 '         '  + 
 '       .align-left {  '  + 
 '         text-align: left;  '  + 
 '       }  '  + 
 '         '  + 
 '       .align-center {  '  + 
 '         text-align: center;  '  + 
 '       }  '  + 
 '       /*Media Queries ------------------------------ */  '  + 
 '         '  + 
 '       @media only screen and (max-width: 600px) {  '  + 
 '         .email-body_inner,  '  + 
 '         .email-footer {  '  + 
 '           width: 100% !important;  '  + 
 '         }  '  + 
 '       }  '  + 
 '         '  + 
 '       @media only screen and (max-width: 500px) {  '  + 
 '         .button {  '  + 
 '           width: 100% !important;  '  + 
 '         }  '  + 
 '       }  '  + 
 '       /* Buttons ------------------------------ */  '  + 
 '         '  + 
 '       .button {  '  + 
 '         background-color: #3869D4;  '  + 
 '         border-top: 10px solid #3869D4;  '  + 
 '         border-right: 18px solid #3869D4;  '  + 
 '         border-bottom: 10px solid #3869D4;  '  + 
 '         border-left: 18px solid #3869D4;  '  + 
 '         display: inline-block;  '  + 
 '         color: #FFF;  '  + 
 '         text-decoration: none;  '  + 
 '         border-radius: 3px;  '  + 
 '         box-shadow: 0 2px 3px rgba(0, 0, 0, 0.16);  '  + 
 '         -webkit-text-size-adjust: none;  '  + 
 '       }  '  + 
 '         '  + 
 '       .button--green {  '  + 
 '         background-color: #22BC66;  '  + 
 '         border-top: 10px solid #22BC66;  '  + 
 '         border-right: 18px solid #22BC66;  '  + 
 '         border-bottom: 10px solid #22BC66;  '  + 
 '         border-left: 18px solid #22BC66;  '  + 
 '       }  '  + 
 '         '  + 
 '       .button--red {  '  + 
 '         background-color: #FF6136;  '  + 
 '         border-top: 10px solid #FF6136;  '  + 
 '         border-right: 18px solid #FF6136;  '  + 
 '         border-bottom: 10px solid #FF6136;  '  + 
 '         border-left: 18px solid #FF6136;  '  + 
 '       }  '  + 
 '       /* Type ------------------------------ */  '  + 
 '         '  + 
 '       h1 {  '  + 
 '         margin-top: 0;  '  + 
 '         color: #2F3133;  '  + 
 '         font-size: 19px;  '  + 
 '         font-weight: bold;  '  + 
 '         text-align: left;  '  + 
 '       }  '  + 
 '         '  + 
 '       h2 {  '  + 
 '         margin-top: 0;  '  + 
 '         color: #2F3133;  '  + 
 '         font-size: 16px;  '  + 
 '         font-weight: bold;  '  + 
 '         text-align: left;  '  + 
 '       }  '  + 
 '         '  + 
 '       h3 {  '  + 
 '         margin-top: 0;  '  + 
 '         color: #2F3133;  '  + 
 '         font-size: 14px;  '  + 
 '         font-weight: bold;  '  + 
 '         text-align: left;  '  + 
 '       }  '  + 
 '         '  + 
 '       p {  '  + 
 '         margin-top: 0;  '  + 
 '         color: #74787E;  '  + 
 '         font-size: 16px;  '  + 
 '         line-height: 1.5em;  '  + 
 '         text-align: left;  '  + 
 '       }  '  + 
 '         '  + 
 '       p.sub {  '  + 
 '         font-size: 12px;  '  + 
 '       }  '  + 
 '         '  + 
 '       p.center {  '  + 
 '         text-align: center;  '  + 
 '       }  '  + 
 '       </style>  '  + 
 '     </head>  '  + 
 '     <body>  '  + 
 '       <span class="preheader">Use this link to reset your password. The link is only valid for 24 hours.</span>  '  + 
 '       <table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0">  '  + 
 '         <tr>  '  + 
 '           <td align="center">  '  + 
 '             <table class="email-content" width="100%" cellpadding="0" cellspacing="0">  '  + 
 '               <tr>  '  + 
 '                 <td class="email-masthead">  '  + 
 '                   <a href="https://example.com" class="email-masthead_name">  '  + 
 '             MIΛ VETRINΛ  '  + 
 '         </a>  '  + 
 '                 </td>  '  + 
 '               </tr>  '  + 
 '               <!-- Email Body -->  '  + 
 '               <tr>  '  + 
 '                 <td class="email-body" width="100%" cellpadding="0" cellspacing="0">  '  + 
 '                   <table class="email-body_inner" align="center" width="570" cellpadding="0" cellspacing="0">  '  + 
 '                     <!-- Body content -->  '  + 
 '                     <tr>  '  + 
 '                       <td class="content-cell">  '  + 
 '                         <h1>Hi '+ name +',</h1>  '  + 
 '                         <p>You recently requested to reset your password for your Mia Vetrina account. Use the button below to reset it. <strong>This password reset is only valid for the next 24 hours.</strong></p>  '  + 
 '                         <!-- Action -->  '  + 
 '                         <table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0">  '  + 
 '                           <tr>  '  + 
 '                             <td align="center">  '  + 
 '                               <!-- Border based button  '  + 
 '                          https://litmus.com/blog/a-guide-to-bulletproof-buttons-in-email-design -->  '  + 
 '                               <table width="100%" border="0" cellspacing="0" cellpadding="0">  '  + 
 '                                 <tr>  '  + 
 '                                   <td align="center">  '  + 
 '                                     <table border="0" cellspacing="0" cellpadding="0">  '  + 
 '                                       <tr>  '  + 
 '                                         <td>  '  + 
 '                                           <a href="'+ url +'" class="button button--green" target="_blank">Reset your password</a>  '  + 
 '                                         </td>  '  + 
 '                                       </tr>  '  + 
 '                                     </table>  '  + 
 '                                   </td>  '  + 
 '                                 </tr>  '  + 
 '                               </table>  '  + 
 '                             </td>  '  + 
 '                           </tr>  '  + 
 '                         </table>  '  + 
 '                         <p>If you did not request a password reset, please ignore this email or <a href="{{support_url}}">contact support</a> if you have questions.</p>  '  + 
 '                         <p>Thanks,  '  + 
 '                           <br>The Mia Vetrina Team</p>  '  + 
 '                         <!-- Sub copy -->  '  + 
 '                         <table class="body-sub">  '  + 
 '                           <tr>  '  + 
 '                             <td>  '  + 
 '                               <p class="sub">If you’re having trouble with the button above, copy and paste the URL below into your web browser.</p>  '  + 
 '                               <p class="sub">{{action_url}}</p>  '  + 
 '                             </td>  '  + 
 '                           </tr>  '  + 
 '                         </table>  '  + 
 '                       </td>  '  + 
 '                     </tr>  '  + 
 '                   </table>  '  + 
 '                 </td>  '  + 
 '               </tr>  '  + 
 '               <tr>  '  + 
 '                 <td>  '  + 
 '                   <table class="email-footer" align="center" width="570" cellpadding="0" cellspacing="0">  '  + 
 '                     <tr>  '  + 
 '                       <td class="content-cell" align="center">  '  + 
 '                         <p class="sub align-center">&copy; 2017 MIΛ VETRINΛ. All rights reserved.</p>  '  + 
 '                         <p class="sub align-center">  '  + 
 '                           Impulso Software, Inc.  '  + 
 '                         </p>  '  + 
 '                       </td>  '  + 
 '                     </tr>  '  + 
 '                   </table>  '  + 
 '                 </td>  '  + 
 '               </tr>  '  + 
 '             </table>  '  + 
 '           </td>  '  + 
 '         </tr>  '  + 
 '       </table>  '  + 
 '     </body>  '  + 
 '  </html>  ' }
// send mail with defined transport object
transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
        return console.log(error);
    }
    console.log('Message %s sent: %s', info.messageId, info.response);
});

}

module.exports = router
