// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require social-share-button

//render loading event
document.addEventListener("turbolinks:before-cache", function () {
    showLoadingBar();
});
document.addEventListener("turbolinks:load", function () {
    setTimeout(function () {
        hideLoadingBar();
    }, 150);

    // show spinner on AJAX start
    $(document).ajaxStart(function () {
        showLoadingBar();
    });

    // hide spinner on AJAX stop
    $(document).ajaxStop(function () {
        setTimeout(function () {
            hideLoadingBar();
        }, 150);
    });
});

function loadThumbnails() {
  $('.youtube-thumbnail:not(.loaded)').each(function() {
    const youtube_id = $(this).data('youtube-id');
    $.ajax({
      url: '/thumbnail/' + youtube_id,
      context: this,
      method: 'get',
      success: function(data) {
        if(data) {
          $(this).css('background-image', 'url(' + data + ')');
          $(this).addClass('loaded');
        }
      }
    });
  });
}

function showLoadingBar() {
    $('._loading-wave-container, ._loading-wave-container-m').show();
}
function hideLoadingBar() {
    $('._loading-wave-container, ._loading-wave-container-m').hide();
}

document.addEventListener("turbolinks:load", function(event) {
  loadThumbnails();
});
