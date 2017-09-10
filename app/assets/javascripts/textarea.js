document.addEventListener("DOMContentLoaded", function(event) {
    //textarea resize
    $("textarea.autosize").on('keydown keyup', function () {
        $(this).height(1).height( $(this).prop('scrollHeight') );
    });
});