document.addEventListener("turbolinks:load", function(event) {
    //focus 하기
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
    $('#search').autocomplete( {
        appendTo: '#search-autocomplete',
        select: function(event, ui) {
            $('#search').val(ui.item.label);
            $('#search').closest('form').submit();
            console.log(ui.item.label);
        }
    });

    $('#search').keyup(function() {
        $.ajax({
            url: '/search/autocomplete',
            data: {
                key: $(this).val()
            },
            success: function(data) {
                $('#search').autocomplete('option', 'source', data);
            }
        });
    });

    //mobile, 맨 처음 input이 비어있지 않을 때
    if ($('#search').val() !== '') {
        onfocus(true);
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
    var ts;
    $(document).bind('touchstart', function(e) {
        ts = e.originalEvent.touches[0].clientY;
    });

    $(document).bind('touchmove', function(e) {
        var te = e.originalEvent.changedTouches[0].clientY;
        if (ts > te) {
            //scroll down
            $('.search-container').addClass('search-bar-up');
        } else {
            //scroll up
            $('.search-container').removeClass('search-bar-up');
        }
    });

    //Result action
    $('#feeds-selector').click(function () {
        renderResult("feed");
    });
    $('#upcomings-selector').click(function () {
        renderResult("upcoming");
    });
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
        console.log("feed selected");
        $('#result-list-feed-m, #result-list-feed').show();
        $('#result-list-upcoming-m, #result-list-upcoming').hide();
        $('.selector-bar-container').css('margin-left', 0);
    } else {
        console.log("upcoming selected");
        $('#result-list-feed-m, #result-list-feed').hide();
        $('#result-list-upcoming-m, #result-list-upcoming').show();
        $('.selector-bar-container').css('margin-left', '50%');
    }
}
