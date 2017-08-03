document.addEventListener("DOMContentLoaded", function(event) {
    //focus 할 때
    $('.input-field').focus(function () {
        onfocus();
    });
    //focus 안할 때
    $('.cancel-field').click(function () {
        $('.input-field').val('');
        $('.input-icon-container').css({
            'flex-grow': 3,
            '-webkit-flex-grow': 3
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
    //X button
    $('.input-esc').click(function () {
        $('.input-field').val('');
        $('.input-esc').hide();
    });

    //Scroll Event
    var iScrollPos = 0;
    scrolling();
    new ResizeSensor($('#search-list-container'), function () {
        scrolling();
    });

    //Result action
    $('#feeds-selector').click(function () {
        renderResult("feed")
    });
    $('#upcomings-selector').click(function () {
        renderResult("upcoming")
    });

    function onfocus() {
        $('.input-icon-container').css({
            'flex-grow': 0,
            '-webkit-flex-grow': 0
        });
        $('.search-input-field').css('width', '84%');
        $('.cancel-field').show();
    }

    function renderResult(params) {
        if(params === "feed") {
            $('#result-list-feed').show();
            $('#result-list-upcoming').hide();
        } else {
            $('#result-list-feed').hide();
            $('#result-list-upcoming').show();
        }
    }

    function scrolling() {
        $(window).scroll(function () {
            var iCurScrollPos = $(this).scrollTop();
            if (iCurScrollPos > iScrollPos) {
                //Scrolling Down
                $('#search-bar').addClass('search-bar-up');
            } else {
                //Scrolling Up
                $('#search-bar').removeClass('search-bar-up');
            }
            iScrollPos = iCurScrollPos;
        });
    }
});