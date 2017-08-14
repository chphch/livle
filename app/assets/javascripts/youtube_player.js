$('document').ready(function() {

    // youtube api
    var tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    // create player object list when iframeAPI is ready
    var videoSize = $('#upcomings-show-mobile').data("size");
    var players = [];
    var readyPlayerSize = 0;
    window.onYouTubeIframeAPIReady = function() {
        $('.show-video-container').each(function() {
            var index = $(this).data("index");
            var player = new YT.Player('youtube-player-' + index, {
                events: {
                    'onReady': onPlayerReady,
                    'onStateChange': onPlayerStateChange,
                    'onPlaybackQualityChange': onPlaybackQualityChange
                }
            });
            player.index = index;
            player.container = $(this);
            player.playButton = $(this).find('.play-button');
            player.qualityButton = $(this).find('.hd-button');
            player.fullScreenButton = $(this).find('.fullscreen-button')
            player.filter = $(this).find('.youtube-player-filter');
            players.push(player);
        });
    };

    // on each player ready
    function onPlayerReady(event) {
        readyPlayerSize++;
        if (readyPlayerSize == videoSize) {
            onAllPlayerReady();
        }
    }

    // set change of play button image
    function onPlayerStateChange(event) {
        var playButton = event.target.playButton;
        if (event.data === YT.PlayerState.PLAYING) {
            playButton.attr('src', "/assets/icon_pause");
        } else if (event.data === YT.PlayerState.PAUSED || event.data === event.data === YT.PlayerState.CUED) {
            playButton.attr('src', "/assets/icon_play");
        }
    }

    // change the color of HD button when the video quality change
    function onPlaybackQualityChange(event) {
        var player = event.target;
        var quality = player.getPlaybackQuality();
        var qualityButton = player.qualityButton;
        if (quality === 'hd720' || quality === 'hd1080' || quality === 'highres') {
            qualityButton.addClass('_white').removeClass('_light-gray');
        } else {
            qualityButton.addClass('_light-gray').removeClass('_white');
        }
    }

    // after all players are ready - set click listeners
    function onAllPlayerReady() {
        players.forEach(function(player){
            player.playButton.on("click", function() {
                onClickPlayButton(player);
            });
            player.qualityButton.on("click", function() {
               onClickQualityButton(player);
            });
            player.fullScreenButton.on("click", function() {
               onClickFullscreenButton(player);
            });
        });
    }

    // on click play button
    function onClickPlayButton(player) {
        if (player.getPlayerState() === 1) {
            player.pauseVideo();
        } else {
            player.playVideo();
            player.filter.hide();
            player.playButton.hide();
        }
    }

    // on click quality button
    function onClickQualityButton(player) {
        var quality = player.getPlaybackQuality();
        if (quality === 'small' || quality === 'medium' || quality === 'large') {
            player.setPlaybackQuality('hd1080');
        } else {
            player.setPlaybackQuality('small');
        }
    }

    // on click fullscreen button
    function onClickFullscreenButton(player) {
        var iframeTag = player.a;
        // TODO: Fullscreen일때 컨트롤바도 만들어야 함..
        if (iframeTag.requestFullScreen) {
            iframeTag.requestFullScreen();
        } else if (iframeTag.webkitRequestFullScreen) {
            iframeTag.webkitRequestFullScreen();
        } else if (iframeTag.msRequestFullScreen) {
            iframeTag.msRequestFullScreen();
        } else if (iframeTag.mozRequestFullScreen) {
            iframeTag.mozRequestFullScreen();
        }
    }

    // show/hide filter on click
    $('.youtube-player-controller').on("click", function (e) {
        if (e.target.nodeName === 'DIV') {
            if ($('.youtube-player-filter').is(':visible') === true) {
                $('.youtube-player-filter').hide();
                $('.youtube-player-buttons').hide();
            } else {
                $('.youtube-player-filter').show();
                $('.youtube-player-buttons').show();
            }
        }
    });

    // set on click lineup
    $('.artist-profile').each(function(index, lineupButton) {
        $(lineupButton).on("click", function() {
            onClickLineupButton($(this));
        });
    });

    // on click lineup button(profile)
    function onClickLineupButton(lineupButton) {
        var buttonIndex = $(lineupButton).data("index");
        var currentVideoIndex = $('#upcomings-show-mobile').data("videoIndex");
        $('.show-video-container').filter(function() {
            return $(this).data("index") == currentVideoIndex;
        }).addClass("_display-none");
        $('.show-video-container').filter(function() {
            return $(this).data("index") == buttonIndex;
        }).removeClass("_display-none");
        players.filter(function(player) {
            return player.index == currentVideoIndex;
        })[0].pauseVideo();
        players.filter(function(player) {
            return player.index == buttonIndex;
        })[0].playVideo();
        setVideoLike(buttonIndex);
        $('#upcomings-show-mobile').data("videoIndex", buttonIndex);
    }
});