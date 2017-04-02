var connections = [
    // github = {
    //     link: "#",
    //     imgSrc: "assets/images/github.png"
    // },
    // linkedin = {
    //     link: "#",
    //     imgSrc: "assets/images/LinkedIn.png"
    // },
    // stackFlow = {
    //     link: "#",
    //     imgSrc: "assets/images/stackoverflow.png"
    // },
    facebook = {
        link: "#",
        imgSrc: "assets/images/Facebook.png"
    },
    twitter = {
        link: "#",
        imgSrc: "assets/images/Twitter.png"
    },
    instagram = {
        link: "#",
        imgSrc: "assets/images/Intsagram.png"
    }
];

for (var i = 0; i < connections.length; i++) {

    var $img = $('<img>').addClass('img-responsive link-ani footer-flex-item-logo').attr('src', connections[i].imgSrc);
    var $a = $('<a>').attr('href', connections[i].link).attr('target', '_blank');

    $a.html($img);

    $(".footer-connect").append($a);

};