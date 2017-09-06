document.addEventListener("DOMContentLoaded", function(event) {
    //focus 할 때
    $('#search-bar-mobile .search-input-field, ._navbar-serach-container').click(function () {
        $('#search-bar-mobile .input-field, ._navbar-search-input').focus();
        onfocus(true);
    });
    //취소버튼 누를 때
    $('.cancel-field').click(function () {
        onfocus(false);
        $('.input-esc').hide();
    });
    //desktop, focusout 할 때
    $('._navbar-serach-container').focusout(function () {
        onfocus(false);
    });

    //search autocomplete
    $('#search').keypress(function() {
        $.ajax({
            url: '/search/autocomplete',
            data: {
                key: $(this).val()
            },
            success: function(data) {
                $('#search').autocomplete({
                    //UI: .ui-autocomplete
                    source: data
                });
            }
        });
    });

    //mobile, 맨 처음 input이 비어있지 않을 때
    if ($('#search-bar-mobile .input-field').val() !== '') {
        $('.search-input-field').css('width', '84%');
        $('.cancel-field').show();
        $('.input-esc').show();
    }

    //텍스트 삭제 button 띄우는 이벤트
    $('.input-field').bind('input', function () {
        if($(this).val() !== '') {
            $('.input-esc').show();
        } else {
            $('.input-esc').hide();
        }
    });
    //삭제 button 클릭시 이벤트
    $('.input-esc').click(function () {
        $('.input-field').val('');
        $('.input-esc').hide();
    });

    //Scroll Event
    $(window).scroll(function () {
        scrolling();
    });
    new ResizeSensor($('#search-list-group-m'), function () {
        $(window).scroll(function () {
            scrolling();
        });
    });

    //Result action
    $('#feeds-selector').click(function () {
        renderResult("feed")
    });
    $('#upcomings-selector').click(function () {
        renderResult("upcoming")
    });

    var lastScrollPos = 0;
    function scrolling() {
        var curScrollPos = $(this).scrollTop();
        if (curScrollPos > lastScrollPos) {
            //Scrolling Down
            $('.search-container').addClass('search-bar-up');
        } else {
            //Scrolling Up
            $('.search-container').removeClass('search-bar-up');
        }
        lastScrollPos = curScrollPos;
    }
});

function onfocus(status) {
    if (status) {
        //for both
        $('#search-bar-mobile .input-icon-container, ._navbar-search-icon-container').css('width', '14%');
        $('#search-bar-mobile .input-field, ._navbar-search-input').css({
            'flex-grow': 1,
            '-webkit-flex-grow': 1
        });

        //for mobile
        $('.search-input-field').css('width', '84%');
        $('.cancel-field').show();
        $('#search-list-group-m').hide();
        $('#search-recent-keywords').show();
    } else {
        //for mobile
        $('#search-bar-mobile .input-field').val('');
        $('#search-bar-mobile .input-icon-container').css('width', '50%');
        $('.search-input-field').css('width', '100%');
        $('#search-bar-mobile .cancel-field').hide();
        $('#search-list-group-m').show();
        $('#search-recent-keywords').hide();

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
        $('#result-list-feed-m').show();
        $('#result-list-upcoming-m').hide();
        $('.selector-bar-container').css('margin-left', 0);
    } else {
        $('#result-list-feed-m').hide();
        $('#result-list-upcoming-m').show();
        $('.selector-bar-container').css('margin-left', '50%');
    }
}