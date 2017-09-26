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

    $target = $('.scroll-target');
    $cardWidth = $target.find('.line-up-card').width();
    $scroll = dir + ($cardWidth * 3);

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
    if ($target.scrollLeft() > 0)
        $('.prev-filter').show();
    else
        $('.prev-filter').hide();

    currentScrollRight = parseFloat($target.scrollLeft())+parseFloat($target.width());
    targetScrollRight = $target[0].scrollWidth - $cardWidth/3;
    if (currentScrollRight >= targetScrollRight)
        $('.next-filter').hide();
    else
        $('.next-filter').show();
}