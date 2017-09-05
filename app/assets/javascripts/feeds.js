document.addEventListener("DOMContentLoaded", function(event) {
    //DESKTOP
    $this = $('#scroll-target');
    $cardWidth = $('.feed-card-group ._column-positioner').width();
    var isLoading = false;

    $('.prev-button').on("click", function () {
        scrollMove('left');
    });
    $('.next-button').on("click", function () {
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

    function scrollMove(click) {
        var dir = click === 'left' ? '-=' : '+=';
        var $scroll = dir + ($cardWidth * 3);

        $this.stop().animate({
            'scrollLeft': $scroll
        }, {
            duration: 350,
            complete: function () {
                scrolling();
            }
        });
    }
});

function scrolling() {
    // console.log("cur pos: "+ $this.scrollLeft());
    if ($this.scrollLeft() > 0) {
        $('#prev-section').show();
    } else {
        $('#prev-section').hide();
    }
}