$(window).scroll(function () {
  if ($(document).scrollTop() > 50) {
    if ($('.navbar-brand').hasClass("byname-lg")) {
      $('.navbar-brand').removeClass("byname-lg").removeClass("fade-in").addClass("byname-sm").addClass("fade-out");
      $('.navbar').removeClass("navbar-lg").addClass("navbar-sm");
      $(".mod-flex").addClass("shrink-container");
    }
  } 
  else {
    if ($('.navbar-brand').hasClass("byname-sm")) {
      $('.navbar-brand').removeClass("byname-sm").removeClass("fade-in").addClass("byname-lg").addClass("fade-out");
      $('.navbar').removeClass("navbar-sm").addClass("navbar-lg");
       $(".mod-flex").removeClass("shrink-container");
    }
  }
});

$('.navbar').on('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend',
  function (e) {
    if ($('.navbar-brand').hasClass("byname-lg")) {
      $('.byname').html('Dream... Create... Design... your inspirations with <span class="logo-font">MIΛ VETRINΛ</span> by impulso');
    } else {
      $('.byname').html('<span class="logo-font">MIΛ VETRINΛ</span> by impulso');
    }
    $('.navbar-brand').removeClass("fade-out");
    $('.navbar-brand').addClass("fade-in");
  });