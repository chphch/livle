document.addEventListener("DOMContentLoaded", function(event) {
    //focus 할 때
    $('.input-field').focus(function () {
        $('.input-icon-container').css({
            'flex-grow': 0,
            '-webkit-flex-grow': 0
        });
        $('.search-input-field').css('width', '84%');
        $('.cancel-field').show();
    });
    //focus 안할 때
    $('.cancel-field').click(function () {
        $('.input-icon-container').css({
            'flex-grow': 2,
            '-webkit-flex-grow': 2
        });
        $('.search-input-field').css('width', '100%');
        $('.cancel-field').hide();
    });

    $('.input-field').bind('input', function () {
        if($(this).val().length > 0) {
            $('.input-esc').show();
        } else {
            $('.input-esc').hide();
        }
    });
    $('.input-esc').click(function () {
        $('.input-field').val('');
        $('.input-esc').hide();
    });
});