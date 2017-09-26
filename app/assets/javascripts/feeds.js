document.addEventListener("turbolinks:load", function(event) {
    //DESKTOP OFFICIAL
    var curPos = 0;
    var max = 6;
    $officialCard(curPos).show();

    for(i = 0; i < max; i ++) {
        $('#prev-button-'+i).on('click', function () {
            if (curPos > 0) {
                $officialCard(curPos - 1).show();
                $officialCard(curPos).hide();
                curPos -= 1;
            }
        });
        $('#next-button-'+i).on('click', function () {
            if (curPos < max-1) {
                $officialCard(curPos + 1).show();
                $officialCard(curPos).hide();
                curPos += 1;
            }
        });
    }

    //DESKTOP COMMON
    $this = $('#scroll-target');
    $cardWidth = $('.feed-card-group ._column-positioner').width();
    var isLoading = false;

    $('.prev-button').bind("click", function () {
        scrollMove('left');
    });
    $('.next-button').bind("click", function () {
        scrollMove('right');
        //infinite scroll
        if ($('#infinite-scrolling').length > 0) {
            var more_contents_url = $('.pagination a.next_page').attr('href');
            if (!isLoading && more_contents_url &&
                $this.scrollLeft() + $('._desktop-container').width() > $this[0].scrollWidth - $cardWidth*3) {
                sendScrollEvent($(location), more_contents_url);
                isLoading = true;
                $.getScript(more_contents_url).done(function (data,textStatus,jqxhr) {
                    isLoading = false;
                    loadThumbnails();
                }).fail(function() {
                    isLoading = false;
                });
            }
        }
    });
});

function $officialCard(pos) {
    return $('.official-'+pos);
}

function scrollMove(click) {
    var dir = click === 'left' ? '-=' : '+=';
    var $scroll = dir + ($cardWidth * 3);

    $this.stop().animate({
        'scrollLeft': $scroll
    }, {
        duration: 350,
        complete: function () {
            // scrolling();
            if ($this.scrollLeft() > 0) {
                $('.prev-button, .prev-filter').show();
            } else {
                $('.prev-button, .prev-filter').hide();
            }
        }
    });
}

function scrolling() {
    console.log("cur pos: "+ $this.scrollLeft());
    if ($this.scrollLeft() > 0) {
        $('.prev-button, .prev-filter').show();
    } else {
        $('.prev-button, .prev-filter').hide();
    }
}