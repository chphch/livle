document.addEventListener("turbolinks:load", function(event) {
    //navbar_desktop.html.erb
    $(window).on('scroll', function() {
        if( $(window).scrollTop() > $(window).height() * 0.02 ) {
            $('._navbar').css('background', 'rgba(18, 18, 18, .9)');
        } else {
            $('._navbar').css('background', 'rgba(18, 18, 18, 0)');
        }
    });

    //navbar desktop login modal
    $('._navbar-login-button').on('click', function () {
        $('body').append(
            '<div id="login-modal" class="modal _hcenter-positioner">\
                <div class="_desktop-session-container">\
                    \
                </div>\
            </div>'
        );
    });

    //works like modal on footer
    $('body').click(function (e) {
        if(!$(e.target).is('._desktop-modal, ._desktop-modal *'))
            $('#footer-modal').remove();
    }).find('._describe-container').on('click', function (e) {
        e.stopPropagation();
    });
});