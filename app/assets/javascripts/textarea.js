document.addEventListener("turbolinks:load", function(event) {
    //textarea resize
    $("textarea.autosize").on('keydown keyup', function () {
        $(this).height(1).height( $(this).prop('scrollHeight') );
    });

    $('textarea').bind('animationend', function () {
        $(this).removeClass('clicked');
    });
    $('textarea').click(function () {
        $(this).addClass('clicked');
    });
});