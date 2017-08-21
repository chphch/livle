document.addEventListener("DOMContentLoaded", function(event) {
    //DESKTOP
    $this = $('#scroll-target');
    $cardWidth = $('.current-list ._column-positioner').width();

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

    $this.scroll(function () {
        if ($this.scrollLeft() > 0) {
            $('#prev-btn').show();
        } else {
            $('#prev-btn').hide();
        }
    });

    function checkPos() {
        if ($this.scrollLeft() > 0) {
            $('#prev-btn').show();
        } else {
            $('#prev-btn').hide();
        }
    }
});