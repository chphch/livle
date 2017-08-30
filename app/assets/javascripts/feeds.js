document.addEventListener("DOMContentLoaded", function(event) {
    //DESKTOP
    $this = $('#scroll-target');
    $cardWidth = $('.current-list ._column-positioner').width();
    var isLoading = false;

    $('.prev-list').on("click", function () {
        scrollMove('left');
    });
    $('.next-list').on("click", function () {
        scrollMove('right');
        //infinite scroll
        if ($('#infinite-scrolling').length > 0) {
            var more_contents_url = $('.pagination a.next_page').attr('href');
            if (!isLoading && more_contents_url &&
                    $this.scrollLeft() + $('._desktop-container').width() > $this[0].scrollWidth - $cardWidth*3) {
                console.log("url: " + more_contents_url);
                isLoading = true;
                $.getScript(more_contents_url).done(function (data,textStatus,jqxhr) {
                    isLoading = false;
                }).fail(function() {
                    isLoading = false;
                });
            }
        }
    });

    $this.on('scroll', function () {
        if ($this.scrollLeft() > $cardWidth) {
            $('#prev-btn').show();
        } else {
            $('#prev-btn').hide();
        }
    });

    function scrollMove(click) {
        var dir = click === 'left' ? '-=' : '+=';
        var $scroll = dir + ($cardWidth * 3);

        $this.stop().animate({
            'scrollLeft': $scroll
        }, 350);
    }
});