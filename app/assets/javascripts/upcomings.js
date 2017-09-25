document.addEventListener("turbolinks:load", function() {
    $('.prev-filter').bind("click", function () {
        upcomingScrollMove('left');
    });
    $('.next-filter').bind("click", function () {
        upcomingScrollMove('right');
    });
});

function upcomingScrollMove(click) {
    var dir = click === 'left' ? '-=' : '+=';

    $cardWidth = $('.scroll-target').find('.line-up-card').width();
    $scroll = dir + ($cardWidth * 3);
    console.log('scroll: ' + $scroll);

    $('.scroll-target').stop().animate({
        'scrollLeft': $scroll
    }, {
        duration: 350,
        complete: function () {
            scrolling();
        }
    });
}

function scrolling() {
    if ($('.scroll-target').scrollLeft() > 0) {
        $('.prev-filter').show();
    } else {
        $('.prev-filter').hide();
    }
}