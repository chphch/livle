document.addEventListener("DOMContentLoaded", function(event) {
    $(':file').change(function () {
        updateImg(this);
    });

    function updateImg(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#upload-profile-img').attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
});