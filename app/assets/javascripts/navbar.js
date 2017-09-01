document.addEventListener("DOMContentLoaded", function(event) {
    //navbar_desktop.html.erb
    $(window).on('scroll', function() {
        if( $(window).scrollTop() > $(window).height() * 0.02 ) {
            $('._navbar').css('background', 'rgba(0, 0, 0, 1)');
        } else {
            $('._navbar').css('background', 'rgba(0, 0, 0, 0)');
        }
    });

    $('._navbar-login-button').on('click', function () {
        $('body').append(
            '<div id="login-modal" class="modal _hcenter-positioner">\
                <div class="_desktop-modal">\
                    \
                </div>\
            </div>'
        );
    });
});