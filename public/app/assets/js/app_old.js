$(document).ready(function () {

  var $canvas;
  var $canvasWidth;
  var $canvasHeight;
  var vCanvas;
  var appLoggedIn = false;



  var delLayer;
  var patt;
  var patt_obj_id;
  var patt_type;
  var palArray = [];
  var palObj = [];
  var currentShowroomName;
  var currentShowroomId = 0;

  var textureExists = false;
  var colorExists = false;
  var floorMode = false;
  var decorMode = false;
  var roomMode = false;
  var artworkCount = 0;

  function setCanvas() {
    if ($(window).width() > 1900 && $(window).width() <= 2500) {
      $canvasWidth = 1200;
      $canvasHeight = 800;
    } else {
      if ($(window).width() > 1550 && $(window).width() <= 1900) {
        $canvasWidth = 999;
        $canvasHeight = 666;
      } else {
        if ($(window).width() <= 1550) {
          $canvasWidth = 900;
          $canvasHeight = 600;
        } else { //browser window is bigger than 2500
          $canvasWidth = 1800;
          $canvasHeight = 1200;
        }
      }
    }

    var newCanvas = $("<canvas>").attr("id", "room-canvas").attr("width", $canvasWidth).attr("height", $canvasHeight);

    $("#canvas").append(newCanvas);
    $canvas = $("#room-canvas");
    vCanvas = document.getElementById('room-canvas');

    $("#my-showrooms").css('width', $canvasWidth);
    $(".tab-pane-mod").css('height', $canvasHeight);

  };

  function clearCanvas() {

    $canvas.removeLayers().drawLayers();
    floorMode = false;
    decorMode = false;
    roomMode = false;
    textureExists = false;
    colorExists = false;
    artworkCount = 0;

  };

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

  function displayShowroom(showroomId, userId) {

    $.ajax({
      url: "/showrooms/showroom/" + showroomId,
      method: "GET"
    }).done(function (data) {
      
      clearCanvas();

      currentShowroomName = data[0].showroom_name;
      currentShowroomId = data[0].showroom_id;


      for (var i = 0; i < data.length; i++) {
        switch (data[i].layer_type) {
          case "texture":
            addTexture(data[i])
            break;
          case "color":
            addColor(data[i])
            break;
          case "room":
            addBaseImg(data[i]);
            break;
          case "decor":
            addBaseImg(data[i]);
            break;
          case "floor":
            addBaseImg(data[i]);
            break;
          default: //art, furniture
            addOtherObjects(data[i]);
        }
      }
    });
  };

  function addTexture(data) {

    $('img[data-obj-id="' + data.object_id + '"]').trigger("click");
  }

  function addColor(data) {

    var colorIndex;
    var colorOpacity;
    // var colorName = palObj[(palArray.indexOf(data.color.toUpperCase()))].name;
    $("#color-name").html("");

    $canvas.removeLayer("color");

    if (textureExists) {
      $canvas.setLayer("texture", {
        opacity: 1
      });
      colorIndex = 1;
      colorOpacity = .9;
    } else {
      colorIndex = 0;
      colorOpacity = 1;
    }


    $canvas.addLayer({
      name: "color",
      type: "rectangle",
      fillStyle: data.color,
      opacity: colorOpacity,
      draggable: false,
      data: {
        color: data.color
      },
      fromCenter: false,
      index: colorIndex,
      x: 0,
      y: 0,
      width: vCanvas.width,
      height: vCanvas.height
    }).drawLayers();

    colorExists = true;
  }

  function addBaseImg(data) {

    $('img[data-obj-id="' + data.object_id + '"]').trigger("click", [data.position_top, data.position_left]);

  }

  function addOtherObjects(data) {
    $('img[data-obj-id="' + data.object_id + '"]').trigger("click", [data.height, data.width, data.position_top, data.position_left]);

  }

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

  function showHandles(layer) {
    return $canvas.setLayer(layer, {
      handle: {
        type: "rectangle",
        visible: true,
        strokeWidth: 1,
        fillStyle: "#00ffff",
        width: 20,
        height: 20,
      }
    });
  };

  function hideHandles(layer) {
    return $canvas.setLayer(layer, {
      handle: {
        type: "rectangle",
        visible: false,
        strokeWidth: 5,
        fillStyle: "#00ffff",
        width: 10,
        height: 10,
      }
    });
  };

  function draw(patt, _this) {
    var objOpacity;

    if (colorExists) objOpacity = 1;
    else objOpacity = 0;

    textureExists = true;
    $canvas.removeLayer("texture");

    $canvas.addLayer({
      name: "texture",
      type: "rectangle",
      fillStyle: patt,
      opacity: objOpacity,
      draggable: false,
      data: {
        type: patt_type,
        objid: patt_obj_id
      },
      fromCenter: false,
      x: 0,
      y: 0,
      width: vCanvas.width,
      height: vCanvas.height
    });

    $canvas.setLayer("color", {
      opacity: .9
    });

    $canvas.moveLayer("texture", 0).drawLayers();

  };

  function loadRooms() {
    $.ajax({
      url: "/objects/rooms",
      method: "GET"
    }).done(function (data) {
      for (var i = 0; i < data.length; i++) {
        var $imgThumbnail = $("<img>").addClass("img-responsive img-thumbnail img-base").attr("data-src", data[i].file_path + data[i].file_name).attr("data-drag", false)
          .attr("data-width", vCanvas.width).attr("data-height", vCanvas.height).attr("data-x", 0).attr("data-y", 0).attr("data-name", "room").attr("data-type", "room")
          .attr("src", data[i].file_path + data[i].file_name).attr("width", "150px").attr("alt", data[i].obj_name).attr("data-obj-id", data[i].id);

        $("#rooms").append($imgThumbnail);

      }
    });

  };
  function loadFloors() {
    $.ajax({
      url: "/objects/floors",
      method: "GET"
    }).done(function (data) {
      for (var i = 0; i < data.length; i++) {
        var $imgThumbnail = $("<img>").addClass("img-responsive img-thumbnail img-base").attr("data-src", data[i].file_path + data[i].file_name).attr("data-drag", false)
          .attr("data-width", vCanvas.width).attr("data-height", vCanvas.height).attr("data-x", 0).attr("data-y", 0).attr("data-name", "floor").attr("data-type", "floor")
          .attr("src", data[i].file_path + data[i].file_name).attr("width", "150px").attr("alt", data[i].obj_name).attr("data-obj-id", data[i].id);

        $("#floors").append($imgThumbnail);

      }
    });

  };

  function loadPaletteDropdown() {
    $.ajax({
      url: "/palettes",
      method: "GET"
    }).done(function (data) {
      for (var i = 0; i < data.length; i++) {
        var $liPalette = $("<li>").addClass("palette").attr("data-id", data[i].id).text(data[i].palette_name);

        $(".palette-well").append($liPalette);

      }
    });

  };

  function loadDecors() {
    $.ajax({
      url: "/objects/decors",
      method: "GET"
    }).done(function (data) {
      for (var i = 0; i < data.length; i++) {
        var $imgThumbnail = $("<img>").addClass("img-responsive img-thumbnail img-base").attr("data-src", data[i].file_path + data[i].file_name).attr("data-drag", false)
          .attr("data-width", vCanvas.width).attr("data-height", vCanvas.height).attr("data-x", 0).attr("data-y", 0).attr("data-name", "decor").attr("data-type", "decor")
          .attr("src", data[i].file_path + data[i].file_name).attr("width", "150px").attr("alt", data[i].obj_name).attr("data-obj-id", data[i].id);

        $("#decors").append($imgThumbnail);

      }
    });
  }

  function loadTextures() {
    var removeTexture = $("<button>").text("No Texture").addClass("btn btn-default no-texture").attr("type", "button");

    $("#textures").append($("<br>")).append(removeTexture).append($("<br>"));

    $.ajax({

      url: "/objects/textures",
      method: "GET"
    }).done(function (data) {
      for (var i = 0; i < data.length; i++) {
        var $imgThumbnail = $("<img>").addClass("img-responsive img-thumbnail img-patt").attr("data-src", data[i].file_path + data[i].file_name).attr("data-drag", false)
          .attr("data-width", vCanvas.width).attr("data-height", vCanvas.height).attr("data-x", 0).attr("data-y", 0).attr("data-name", "texture").attr("data-type", "texture")
          .attr("src", data[i].file_path + data[i].file_name).attr("width", "150px").attr("alt", data[i].obj_name).attr("data-obj-id", data[i].id);

        $("#textures").append($imgThumbnail);

      }
    });
  }

  function loadArtwork() {
    $.ajax({
      url: "/objects/artwork",
      method: "GET"
    }).done(function (data) {
      for (var i = 0; i < data.length; i++) {
        var $imgThumbnail = $("<img>").addClass("img-responsive img-thumbnail img-art").attr("data-src", data[i].file_path + data[i].file_name).attr("data-drag", true).attr("data-height", data[i].height)
          .attr("data-width", data[i].width).attr("data-x", 100).attr("data-y", 20).attr("data-name", data[i].obj_name).attr("data-copy", 1)
          .attr("data-type", "art").attr("src", data[i].file_path + data[i].file_name).attr("width", "150px").attr("alt", data[i].obj_name).attr("data-obj-id", data[i].id);

        $("#artwork").append($imgThumbnail);

      }
    });
  }

  function loadFurniture() {
    $.ajax({
      url: "/objects/furniture",
      method: "GET"
    }).done(function (data) {
      for (var i = 0; i < data.length; i++) {
        var $imgThumbnail = $("<img>").addClass("img-responsive img-thumbnail img-furn").attr("data-src", data[i].file_path + data[i].file_name).attr("data-drag", true).attr("data-height", data[i].height)
          .attr("data-width", data[i].width).attr("data-x", 100).attr("data-y", 100).attr("data-name", data[i].obj_name).attr("data-copy", 1)
          .attr("data-type", "furn").attr("src", data[i].file_path + data[i].file_name).attr("width", "150px").attr("alt", data[i].obj_name).attr("data-obj-id", data[i].id);

        $("#furniture").append($imgThumbnail);

      }
    });
  }

  //*********************app starts executing here***********************

  setCanvas();

  checkUser();

  loadPaletteDropdown();

  loadRooms();

  loadFloors();

  loadDecors();

  loadTextures();

  loadArtwork();

  loadFurniture();

// $canvas.detectPixelRatio();
  // $canvas.restoreCanvas();

  //*********************Event Listeners**********************************

  $(document).on("click", ".palette", function () {
    var palName = $(this).text();
    var paId = $(this).data("id");
    $("#btn-palette").html(palName + "<span class=\"caret\"></span>");

    $.ajax({
      url: "/palettes/palette/" + paId + "/object",
      method: "GET"
    }).done(function (data) {
      palArray = [];
      palObj = data;
      console.log(palObj);
      for (var i = 0; i < data.length; i++) {
        palArray.push(data[i].hex);
      }
      $("#full").spectrum({
        color: "#ECC",
        showInput: true,
        className: "full-spectrum",
        showInitial: true,
        togglePaletteOnly: true,
        togglePaletteMoreText: "more",
        togglePaletteLessText: "less",
        hideAfterPaletteSelect: true,
        showPalette: true,
        showPaletteOnly: false,
        showSelectionPalette: true,
        maxSelectionSize: 10,
        preferredFormat: "name",
        sessionStorageKey: "spectrum.impulso",
        move: function (color) {

        },
        show: function () {

        },
        beforeShow: function () {

        },
        hide: function () {

        },
        change: function (color) {

          var colorIndex;
          var colorOpacity;
          var colorName = palObj[(palArray.indexOf(color.toHexString().toUpperCase()))].name;
          $("#color-name").html(colorName);

          $canvas.removeLayer("color");

          if (textureExists) {
            $canvas.setLayer("texture", {
              opacity: 1
            });
            colorIndex = 1;
            colorOpacity = .9;
          } else {
            colorIndex = 0;
            colorOpacity = 1;
          }


          $canvas.addLayer({
            name: "color",
            type: "rectangle",
            fillStyle: color.toHexString(),
            opacity: colorOpacity,
            draggable: false,
            data: {
              color: color.toHexString()
            },
            fromCenter: false,
            index: colorIndex,
            x: 0,
            y: 0,
            width: vCanvas.width,
            height: vCanvas.height
          }).drawLayers();

          colorExists = true;
        },
        palette: [palArray]
      });
    });

  });

  $('#btnRegister').on('click', function () {

    $("a[href='#registration']").click();

  });

  $(document).on("click", ".my-showroom", function () {
    var showroomId = $(this).data("id");
    var userId = $(this).data("user-id");

    displayShowroom(showroomId, userId);

  });

  $(document).on("click", ".img-base", function (e, h, w, t, l) {
    var height;
    var width;
    var top;
    var left;

    if (h) height = h;
    else height = $(this).data("height");

    if (w) width = w;
    else width = $(this).data("width");

    if (t) top = t;
    else top = $(this).data("y");

    if (l) left = l;
    else left = $(this).data("x");

    if (floorMode) $canvas.removeLayer("floor");
    if (roomMode) $canvas.removeLayer("room");
    if (decorMode) $canvas.removeLayer("decor");

    floorMode = false;
    decorMode = false;
    roomMode = false;

    var objIndex;

    if ($(this).data("type") === "room") {
      if (colorExists) $canvas.removeLayer("color");
      if (textureExists) $canvas.removeLayer("texture");
      colorExists = false;
      textureExists = false;
      objIndex = 0;
      $("#full").spectrum("disable");
    } else {
      $("#full").spectrum("enable");
      if (colorExists && textureExists) objIndex = 2 + artworkCount;
      if ((colorExists && !(textureExists)) || (!(colorExists) && textureExists)) objIndex = 1 + artworkCount;
      if (!(colorExists) && !(textureExists)) objIndex = 0 + artworkCount;
    }

    switch ($(this).data("type")) {
      case "floor":
        floorMode = true;
        break;
      case "decor":
        decorMode = true;
        break;
      case "room":
        roomMode = true;
        break;
    }

    $canvas.addLayer({
      type: "image",
      name: $(this).data("name"),
      source: $(this).data("src"),
      draggable: $(this).data("drag"),
      data: {
        type: $(this).data("type"),
        objid: $(this).data("obj-id")
      },
      opacity: 1,
      fromCenter: false,
      intangible: true,
      index: objIndex,
      x: left,
      y: top,
      width: width,
      height: height
    }).drawLayers();

  });

  $(document).on("click", ".img-art, .img-furn", function (e, h, w, t, l) {
    var height;
    var width;
    var top;
    var left;

    if (h) height = h;
    else height = this.naturalHeight / 2;

    if (w) width = w;
    else width = this.naturalWidth / 2;

    if (t) top = t;
    else top = $(this).data("y");

    if (l) left = l;
    else left = $(this).data("x");

    var objIndex;
    var layerName = $(this).data("name") + "_" + $(this).data("copy");

    $canvas.addLayer({
      type: "image",
      name: layerName,
      source: $(this).data("src"),
      draggable: $(this).data("drag"),
      data: {
        type: $(this).data("type"),
        objid: $(this).data("obj-id")
      },
      fromCenter: false,
      x: left,
      y: top,
      width: width,
      height: height,
      resizeFromCenter: false,
      constrainProportions: true,
      opacity: 1,
      shadowColor: '#222',
      shadowBlur: 10,
      handlePlacement: "corners",
      dblclick: function (layer) {
        delLayer = layer;
        $("#deleteModal").modal({
          backdrop: "static",
          keyboard: true
        });
      },
      mouseover: function (layer) {
        showHandles(layer).drawLayers();
      },
      mouseout: function (layer) {
        hideHandles(layer).drawLayers();
      }
    }).drawLayers();

    if ($(this).data("type") === "art") {
      artworkCount++;
      if (roomMode) objIndex = 1;
      else {
        if (colorExists && textureExists) objIndex = 2;
        if ((colorExists && !(textureExists)) || (!(colorExists) && textureExists)) objIndex = 1;
        if (!(colorExists) && !(textureExists)) objIndex = 0;
      }
      $canvas.moveLayer(layerName, objIndex).drawLayers();
    }

    //increment copy number so if the same image is added to canvas, it will take on the next copy number
    var num = $(this).data("copy") + 1;

    $(this).data("copy", num);

  });

  $(document).on("click", ".img-patt", function () {
    patt_type = $(this).data("type");
    patt_obj_id = $(this).data("obj-id");

    patt = $canvas.createPattern({
      source: $(this).data("src"),
      repeat: "repeat",
      load: draw
    });

  });

  $(document).on("click", ".no-texture", function () {
    textureExists = false;

    $canvas.setLayer("color", {
      opacity: 1
    });

    $canvas.removeLayer("texture").drawLayers();
  });

  $(document).on("click", "#delete-obj", function () {

    $canvas.removeLayer(delLayer).drawLayers();

  });

  $('#btn-clear').on('click', function () {

    clearCanvas();

  });

  $(document).on("click", "#btn-download", function (e) {

    checkUser();
    if (appLoggedIn) {
      var fileName = "Showroom_" + moment().format("YYYY-MM-DD-h:mm:ss");
      var dataURL = vCanvas.toDataURL('image/png');
      $(this).attr("download", fileName).attr("href", dataURL);
    } else $("#login-modal").modal("toggle");
  });

  $('#btn-save').on('click', function () {

    checkUser();
    if (appLoggedIn) {

      //prompt user for showroom name if new, or if they want to save as new name
      if (currentShowroomName) {
        $("#curr-showroom").text(currentShowroomName);
        $("#save-new").addClass("hidden");
        $("#save-existing").removeClass("hidden");
        $("#save-modal").modal("toggle");
      } else {
        $("#save-new").removeClass("hidden");
        $("#save-existing").addClass("hidden");
        $("#save-modal").modal("toggle");
      }
    } else $("#login-modal").modal("toggle");
  });

  function ajaxSaveShowroom(url, parm, type) {
    //send request to save showroom
    $.ajax({
      url: url,
      data: parm,
      method: type
    }).done(function (data) {
      //check for success
      console.log(data);
      saveLayers(data.showroom_id);
    });

  }

  function ajaxSaveLayer(parm) {
    //send request to save showroom
    $.ajax({
      url: "/showrooms/create_layer",
      data: parm,
      method: "POST"
    }).done(function (data) {
      //check for success
      console.log(data);
    });

  }

  function ajaxDelLayers(parm) {
    //send request to delete layers
    $.ajax({
      url: "/showrooms/delete_layers/" + parm,
      method: "DELETE"
    }).done(function (data) {
      //check for success
      console.log(data);
    });

  }

  function saveLayers(showroomId) {
    var parmLayer = {
      name: "",
      canvas_id: 0,
      layer_index: 0,
      height: 0,
      width: 0,
      position_top: 0,
      position_left: 0,
      color: "",
      opacity: 0,
      layer_type: "",
      object_type: "",
      object_id: 0,
      showroom_id: 0
    };

    //create layers

    var l = $canvas.getLayers(function (layer) {
      return (layer.name);
    });

    for (var i = 0; i < l.length; i++) {
      parmLayer.name = l[i].name;
      parmLayer.canvas_id = l[i].canvas_id;
      parmLayer.layer_index = l[i].index;
      parmLayer.height = l[i].height;
      parmLayer.width = l[i].width;
      parmLayer.opacity = (l[i].opacity * 100);
      parmLayer.layer_type = l[i].name;
      parmLayer.position_top = l[i].y;
      parmLayer.position_left = l[i].x;
      if (l[i].name === "color") {
        parmLayer.color = l[i].data.color;
        parmLayer.object_type = "color";
        parmLayer.object_id = 0;
      } else {
        parmLayer.object_type = l[i].data.type;
        parmLayer.object_id = l[i].data.objid;
        parmLayer.color = "";
      }
      parmLayer.showroom_id = showroomId;
      console.log(parmLayer);
      ajaxSaveLayer(parmLayer);
    }

  }

  $('#save-show').on('click', function () {
    var parmShowroomName = $("#showroom-name").val().trim();
    //reset field
    //$("#showroom-name").reset();  Vinny's old code
    $("#showroom-name").trigger("reset");  // new trigger function to reset
    var reqType;
    var parmShowroomId;
    var ajaxURL = "/showrooms/create_showroom";
    var showroomReturnData;
    var layerReturnData;
    var parmObj = {
      showroom_id: 0,
      showroom_name: "",
      user_id: 0
    };

    if ((currentShowroomName) && (parmShowroomName == "")) {
      //we are updating a current showroom
      parmShowroomId = currentShowroomId;
      parmShowroomName = currentShowroomName;
      reqType = "PUT"
    } else if (!(currentShowroomName)) {
      //we are creating a brand new showroom
      parmShowroomId = 0;
      reqType = "POST"
    } else {
      //we are creating a new showroom based on the current showroom (save as)
      parmShowroomId = 0;
      reqType = "POST"
    }

    var sessionData = JSON.parse(sessionStorage.userSession);

    parmObj.showroom_id = parmShowroomId;
    parmObj.showroom_name = parmShowroomName;
    parmObj.user_id = sessionData.user_id;

    //create showroom if necessary
    if (reqType == "POST") {
      ajaxSaveShowroom(ajaxURL, parmObj, reqType);
    } else {
      //delete original layers and save the new ones
      ajaxDelLayers(parmShowroomId);
      saveLayers(parmShowroomId);
    }

    //refresh my showrooms
    getShowrooms(sessionData.user_id);
  });


  $("#full").spectrum({
    color: "white",
    showInput: true,
    className: "full-spectrum",
    showInitial: true,
    togglePaletteOnly: true,
    togglePaletteMoreText: "more",
    togglePaletteLessText: "less",
    hideAfterPaletteSelect: true,

    showPalette: true,
    showPaletteOnly: false,
    showSelectionPalette: true,
    maxSelectionSize: 10,
    preferredFormat: "rgb",
    sessionStorageKey: "spectrum.impulso",
    move: function (color) {

    },
    show: function () {

    },
    beforeShow: function () {

    },
    hide: function () {

    },
    change: function (color) {

      var colorIndex;
      var colorOpacity;

      $canvas.removeLayer("color");

      if (textureExists) {
        $canvas.setLayer("texture", {
          opacity: 1
        });
        colorIndex = 1;
        colorOpacity = .9;
      } else {
        colorIndex = 0;
        colorOpacity = 1;
      }


      $canvas.addLayer({
        name: "color",
        type: "rectangle",
        fillStyle: color.toHexString(),
        opacity: colorOpacity,
        draggable: false,
        data: {
          color: color.toHexString()
        },
        fromCenter: false,
        index: colorIndex,
        x: 0,
        y: 0,
        width: vCanvas.width,
        height: vCanvas.height
      }).drawLayers();

      colorExists = true;
    },
    palette: [
      ["rgb(0, 0, 0)", "rgb(67, 67, 67)", "rgb(102, 102, 102)",
        "rgb(204, 204, 204)", "rgb(217, 217, 217)", "rgb(255, 255, 255)",
        "rgb(152, 0, 0)", "rgb(255, 0, 0)", "rgb(255, 153, 0)", "rgb(255, 255, 0)", "rgb(0, 255, 0)",
        "rgb(0, 255, 255)", "rgb(74, 134, 232)", "rgb(0, 0, 255)", "rgb(153, 0, 255)", "rgb(255, 0, 255)",
        "rgb(230, 184, 175)", "rgb(244, 204, 204)", "rgb(252, 229, 205)", "rgb(255, 242, 204)", "rgb(217, 234, 211)",
        "rgb(208, 224, 227)", "rgb(201, 218, 248)", "rgb(207, 226, 243)", "rgb(217, 210, 233)", "rgb(234, 209, 220)",
        "rgb(221, 126, 107)", "rgb(234, 153, 153)", "rgb(249, 203, 156)", "rgb(255, 229, 153)", "rgb(182, 215, 168)",
        "rgb(162, 196, 201)", "rgb(164, 194, 244)", "rgb(159, 197, 232)", "rgb(180, 167, 214)", "rgb(213, 166, 189)",
        "rgb(204, 65, 37)", "rgb(224, 102, 102)", "rgb(246, 178, 107)", "rgb(255, 217, 102)", "rgb(147, 196, 125)",
        "rgb(118, 165, 175)", "rgb(109, 158, 235)", "rgb(111, 168, 220)", "rgb(142, 124, 195)", "rgb(194, 123, 160)",
        "rgb(166, 28, 0)", "rgb(204, 0, 0)", "rgb(230, 145, 56)", "rgb(241, 194, 50)", "rgb(106, 168, 79)",
        "rgb(69, 129, 142)", "rgb(60, 120, 216)", "rgb(61, 133, 198)", "rgb(103, 78, 167)", "rgb(166, 77, 121)",
        "rgb(91, 15, 0)", "rgb(102, 0, 0)", "rgb(120, 63, 4)", "rgb(127, 96, 0)", "rgb(39, 78, 19)",
        "rgb(12, 52, 61)", "rgb(28, 69, 135)", "rgb(7, 55, 99)", "rgb(32, 18, 77)", "rgb(76, 17, 48)"
      ]
    ]
  });

  // $(document).on("resize", $canvas, function () {

  //   $canvas.drawLayers();

  // });


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

  $("#home").on("click", function () {
    var currentURL = window.location.origin;

    window.location = currentURL + "/app"

  });

  $("#how-To").on("click", function () {
    $("#how-To-Modal").modal("toggle");
  });

  $("#about").on("click", function () {
    var currentURL = window.location.origin;

    window.location = currentURL + "/app/about"

  });

  $("#contact").on("click", function () {
    var currentURL = window.location.origin;

    window.location = currentURL + "/app/contact"

  });

}); // end document ready