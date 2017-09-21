// Used in mobile
document.addEventListener("turbolinks:load", function(event) {
  var isLoading = false;
  if ($('#infinite-scrolling').length > 0) {
    $(window).on('scroll', function() {
      var more_contents_url = $('.pagination a.next_page').attr('href');
      if (!isLoading && more_contents_url && $(window).scrollTop() > $(document).height() - $(window).height() - 240) {
        sendScrollEvent($(location), more_contents_url);
        isLoading = true;
        $.getScript(more_contents_url).done(function (data,textStatus,jqxhr) {
          isLoading = false;
          loadThumbnails();
        }).fail(function() {
          isLoading = false;
        });
      }
    });
  }
});
