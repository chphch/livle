document.addEventListener("turbolinks:load", function(event) {
    // modal display
    $('.modal').on('click', function (e) {
        if(e.target == this && $(this).css('display') !== 'none') {
            $(this).removeClass('_display-flex');
        }
    });
});