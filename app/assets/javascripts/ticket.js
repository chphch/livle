document.addEventListener("turbolinks:load", function(event) {
    const $info = $('.detail-info');
    const $notice = $('.detail-notice');
    const $selector_bar = $('.selector-bar');

    $info.on('click', function () {
        $selector_bar.css('margin-left', '0');
        $('.detail-info-container').show();
        $('.detail-notice-container').hide();
    });
    $notice.on('click', function () {
        $selector_bar.css('margin-left', '50%');
        $('.detail-info-container').hide();
        $('.detail-notice-container').show();
    });
});