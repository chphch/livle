document.addEventListener("DOMContentLoaded", function(event) {
    ///(with '_' -> _navbar_desktop, without '_' -> _search_bar_mobile)

    //focus 할 때
    $('#search-bar .search-input-field, ._navbar-serach-container').click(function () {
        $('#search-bar .input-field, ._navbar-search-input').focus();
        onfocus(true);
    });
    //취소버튼을 누를 때
    $('.cancel-field').click(function () {
        onfocus(false);
    });
    //focusout 할 때
    $('._navbar-serach-container').focusout(function () {
        onfocus(false);
    });

    //맨 처음 input이 비어있지 않을 때
    if ($('.input-field').val() !== '') {
        onfocus();
        $('.input-esc').show();
    }
    //X button 띄우는 이벤트
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

    function onfocus(status) {
        if (status) {
            //for both
            $('#search-bar .input-icon-container, ._navbar-search-icon-container').css('width', '14%');
            $('#search-bar .input-field, ._navbar-search-input').css({
                'flex-grow': 1,
                '-webkit-flex-grow': 1
            });

            //for mobile
            $('.search-input-field').css('width', '84%');
            $('.cancel-field').show();
        } else {
            //for mobile
            $('#search-bar .input-field').val('');
            $('#search-bar .input-icon-container').css('width', '50%');
            $('.search-input-field').css('width', '100%');
            $('#search-bar .cancel-field').hide();

            //for desktop
            $('._navbar-search-icon-container').css('width', '48%');
            $('.input-field, ._navbar-search-input').css({
                'flex-grow': 0,
                '-webkit-flex-grow': 0
            });
        }
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