$(document).ready(function () {

  $('.login-form').validator();
  $('.registration-form').validator();

  var appLoggedIn = false;

  function getShowrooms(userId) {

    //retrieve saved Showrooms, if any
    $.ajax({
      url: "/showrooms/user/" + userId,
      method: "GET"
    }).done(function (data) {
      $("#my-showrooms").empty();
      if (data.length > 0) {
        $(".showrooms-container").removeClass("hidden");
        var $h3 = $("<h3>").text("My Showrooms");
        $("#my-showrooms").append($h3).append("<hr>");
      } else $(".showrooms-container").addClass("hidden");

      for (var i = 0; i < data.length; i++) {
        var $divShowroom = $("<div>").addClass("my-showroom").attr("data-user-id", data[i].user_id)
          .attr("data-id", data[i].id).text(data[i].showroom_name);

        $("#my-showrooms").append($divShowroom);
      }
    });
  };

  function checkUser() {

    if (sessionStorage.userSession) {

      var data = JSON.parse(sessionStorage.userSession);

      //check to see if session is expired
      console.log(moment.utc()._d);
      console.log(moment.utc(data.cookie.expires)._d);

      if (moment.utc()._d > moment.utc(data.cookie.expires)._d) {
        //cookie expired
        appLoggedIn = false;
        sessionStorage.removeItem("userSession");
        $("#btn-download").removeAttr("download").removeAttr("href");
        $(".account-container").css('visibility', 'hidden');
        $("#sign-out").addClass("hidden");

        // Hide sign-in button.
        $("#sign-in").removeClass("hidden");
        $(".showrooms-container").addClass("hidden");

      } else {
        //user session is in sessionStorage and has not expired
        appLoggedIn = true;
        $("#btn-download").attr("download", "my-file-name.png").attr("href", "#");
        // Set the user's profile pic and name.
        // this.userPic.css("decorImage", "url(" + profilePicUrl + ")");
        $("#user-name").text("Welcome, " + data.first_name);

        getShowrooms(data.user_id);

        // Show user's profile and sign-out button.
        $(".account-container").css('visibility', 'visible');
        $("#sign-out").removeClass("hidden");

        // Hide sign-in button.
        $("#sign-in").addClass("hidden");
      }
    } else {
      appLoggedIn = false;
      sessionStorage.removeItem("userSession");
      $("#btn-download").removeAttr("download").removeAttr("href");

      $(".account-container").css('visibility', 'hidden');
      $("#sign-out").addClass("hidden");

      // Hide sign-in button.
      $("#sign-in").removeClass("hidden");
      $(".showrooms-container").addClass("hidden");


    }


  };

  checkUser();

  $('#btnRegister').on('click', function () {

    $("a[href='#registration']").click();

  });

  $(document).on("click", ".my-showroom", function () {
    var showroomId = $(this).data("id");
    var userId = $(this).data("user-id");

    displayShowroom(showroomId, userId);

  });

  // User register/login

  $("#sign-in").on("click", function () {
    $("#login-modal").modal("toggle");
  });

  $("#sign-out").on("click", function () {

    appLoggedIn = false;
    sessionStorage.removeItem("userSession");
    $("#btn-download").removeAttr("download").removeAttr("href");

    $(".account-container").css('visibility', 'hidden');
    $("#sign-out").addClass("hidden");

    // Hide sign-in button.
    $("#sign-in").removeClass("hidden");
    $(".showrooms-container").addClass("hidden");

  });

  var currentURL = window.location.origin;

  $("#login-submit").on("click", function (e) {
    e.preventDefault();
    var userN = $("#login-user-name").val();
    var pass = $("#login-password").val();

    //reset fields
    $('.login-form').each(function () {
      this.reset();
    });

    var userSession = {
      user_name: userN,
      password_hash: pass
    }

    // console.log(userSession)

    //AJAX post the data to the friends API.
    $.post("/login/user_login", userSession, function (data) {
      console.log(data);
      if (data.logged_in == true) {
        appLoggedIn = true;
        sessionStorage.setItem("userSession", JSON.stringify(data));
        $("#btn-download").attr("download", "my-file-name.png").attr("href", "#");
        getShowrooms(data.user_id);

        // var profilePicUrl = data.photoURL;

        // Set the user's profile pic and name.
        // this.userPic.css("decorImage", "url(" + profilePicUrl + ")");
        $("#user-name").text("Welcome, " + data.first_name);

        // Show user's profile and sign-out button.
        $(".account-container").css('visibility', 'visible');
        $("#sign-out").removeClass("hidden");

        // Hide sign-in button.
        $("#sign-in").addClass("hidden");
        $("#login-modal").modal("toggle");
        // process user logged in
      } else {
        appLoggedIn = false;
        sessionStorage.removeItem("userSession");
        $("#btn-download").removeAttr("download").removeAttr("href");

        $(".account-container").css('visibility', 'hidden');
        $("#sign-out").addClass("hidden");
        $("#sign-in").removeClass("hidden");
        $(".showrooms-container").addClass("hidden");


        //display error message
        var errorMsg;
        switch (data.status_code) {
          case 103:
            errorMsg = "The Password entered is invalid.";
            break;
          case 104:
            errorMsg = "An account does not exist for the given User Name.";
            break;
          default:
            errorMsg = "Error Code: " + data.status_code;
            break;
        }

        $("#login-error").text(errorMsg);
      }


    });

  });

  $("#reg-save").on("click", function (e) {
    e.preventDefault();
    var userName = $("#reg-user-name").val();
    var firstName = $("#reg-first-name").val();
    var lastName = $("#reg-last-name").val();
    var email = $("#reg-email").val();
    var password = $("#reg-password").val();

    //reset fields
    $('.registration-form').each(function () {
      this.reset();
    });

    var newUser = {
      username: userName,
      first_name: firstName,
      last_name: lastName,
      email: email,
      password_hash: password
    };

    $.post("/login/user_signup", newUser, function (data) {
      console.log(data);
      if (data.logged_in == true) {

        appLoggedIn = true;
        sessionStorage.setItem("userSession", JSON.stringify(data));
        $("#btn-download").attr("download", "my-file-name.png").attr("href", "#");

        $("#user-name").text("Welcome, " + data.first_name);

        // Show user's profile and sign-out button.
        $(".account-container").css('visibility', 'visible');
        $("#sign-out").removeClass("hidden");

        // Hide sign-in button.
        $("#sign-in").addClass("hidden");
        $("#login-modal").modal("toggle");

        getShowrooms(data.user_id)

      } else {
        $(".account-container").css('visibility', 'hidden');
        $("#sign-out").addClass("hidden");
        $("#sign-in").removeClass("hidden");

        //display error message
        var errorMsg;
        switch (data.status_code) {
          case 101:
            errorMsg = "An account with that Email already exists.";
            break;
          case 102:
            errorMsg = "An account with that User Name already exists.";
            break;
          default:
            errorMsg = "Error Code: " + data.status_code;
            break;
        }

        $("#reg-error").text(errorMsg);
      }
    });

  }); //end reg-save

  $("#sign-out").on("click", function () {
    $.ajax({
      url: "/login/sign_out",
      method: "get",
      data: ""
    }).done(function (data) {
      console.log(data)
    });
  })


  $("#how-To").on("click", function () {
    // $("#how-To-Modal").modal("toggle");
  });

  $("#home").on("click", function () {
    var currentURL = window.location.origin;

    window.location= currentURL + "/app"

  });

  $("#about").on("click", function () {
    var currentURL = window.location.origin;

    window.location= currentURL + "/app/about"

  });

  $("#contact").on("click", function () {
    var currentURL = window.location.origin;

    window.location= currentURL + "/app/contact"

  });

}); // end document ready