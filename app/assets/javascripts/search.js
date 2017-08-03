document.addEventListener("DOMContentLoaded", function(event) {
    //focus 할 때
    $('.input-field').focus(function () {
        onfocus();
    });
    //focus 안할 때
    $('.cancel-field').click(function () {
        $('.input-field').val('');
        $('.input-icon-container').css({
            'flex-grow': 2,
            '-webkit-flex-grow': 2
        });
        $('.search-input-field').css('width', '100%');
        $('.cancel-field').hide();
    });

    if($('.input-field').val() !== '') {
        onfocus();
        $('.input-esc').show();
    }
    $('.input-field').bind('input', function () {
        if($(this).val() !== '') {
            $('.input-esc').show();
        } else {
            $('.input-esc').hide();
        }
    });
    $('.input-esc').click(function () {
        $('.input-field').val('');
        $('.input-esc').hide();
    });

    function onfocus() {
        $('.input-icon-container').css({
            'flex-grow': 0,
            '-webkit-flex-grow': 0
        });
        $('.search-input-field').css('width', '84%');
        $('.cancel-field').show();
    }
});