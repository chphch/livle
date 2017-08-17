document.addEventListener("DOMContentLoaded", function(event) {
    //DESKTOP
    $this = $('#scroll-target');
    $cardWidth = $('.feed-list').width();

    $('.prev-list').bind("click", function () {
        scrollMove('left');
    });
    $('.next-list').bind("click", function () {
        scrollMove('right');
    });

    function scrollMove(click) {
        var dir = click === 'left' ? '-=' : '+=';
        var $scroll = dir + ($cardWidth * 3);

        $this.stop().animate({
            'scrollLeft': $scroll
        }, 500);
    }
});