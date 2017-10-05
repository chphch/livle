document.addEventListener("turbolinks:load", function () {
    $('.is_curation').change(function () {
        var id = $(this).data('id');
        $('#edit_feed_'+id).submit();
    });

    $(".new-feed_artist, .new-upcoming-artist").on('click', function(e) {
        e.preventDefault();
        var $new = $(this).prev();
        $new.toggle();
        $(this).text( $new.is(":visible") ? "Click to cancel" : "Click to add" );
    });

    $('.artist_name').autocomplete( {
        appendTo: "#artist-autocomplete",
        select: function(event, ui) {
            var id = $(this).data('id');
            $('input:hidden[data-id=' + id + ']').val(ui.item.id);
            $('form[data-id=' + id + ']').submit();
            return false;
        }
    }).autocomplete( "instance" )._renderItem = function( ul, item ) {
        return $( "<li>" )
            .append( "<div><img src='" + item.image_url + "' style='width: 50px; height: 50px'/>" + item.label + "</div>" )
            .appendTo( ul );
    };

    $('.artist_name').keyup(function() {
        $.ajax({
            url: '/artists/autocomplete',
            data: {
                key: $(this).val()
            },
            context: this,
            success: function(data) {
                data = data.map(function(a) { return { id: a.id, label: a.name, image_url : a.image_url.url }; });
                $(this).autocomplete("option", "source", data);
                $(this).autocomplete("search", $(this).val());
            }
        });
    });

    //feed
    const $officialButton = $('.official-button');
    const $commonButton = $('.common-button');
    toggleFeedGroup('official'); //default
    toggleFeedButton('official'); //default

    $officialButton.on('click', function () {
        toggleFeedGroup('official');
        toggleFeedButton('official');
    });
    $commonButton.on('click', function () {
        toggleFeedGroup('common');
        toggleFeedButton('common');
    });

    function toggleFeedGroup(group) {
        $officialGroup = $('.official-group');
        $commonGroup = $('.common-group');
        group === 'official' ? $officialGroup.show() : $officialGroup.hide();
        group === 'common' ? $commonGroup.show() : $commonGroup.hide();
    }
    function toggleFeedButton(group) {
        if (group === 'official') {
            $officialButton.addClass('button-select');
            $commonButton.removeClass('button-select');
        } else {
            $officialButton.removeClass('button-select');
            $commonButton.addClass('button-select');
        }
    }
});
