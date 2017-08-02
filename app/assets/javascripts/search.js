document.addEventListener("DOMContentLoaded", function(event) {
    //focus 할 때
    $('.input-field').focus(function () {
        $('.input-icon-container').css('flex-grow', 0);
        $('.search-input-field').css('width', '80%');
        $('.input-esc').show();
    });
    //focus 안할 때
    $('.input-field').blur(function () {
        $('.input-icon-container').css('flex-grow', 2);
        $('.search-input-field').css('width', '100%');
        $('.input-esc').hide();
    });
});