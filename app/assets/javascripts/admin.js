document.addEventListener("turbolinks:load", function () {
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
