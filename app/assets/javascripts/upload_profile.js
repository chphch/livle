document.addEventListener("DOMContentLoaded", function(event) {
   $('#profile').change(function () {
       updateImg(this);
   });
});

var updateImg = function (input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#upload-profile-img').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
        // console.log(input.files[0]);
    }
}