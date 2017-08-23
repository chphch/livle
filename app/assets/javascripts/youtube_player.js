document.addEventListener("DOMContentLoaded", function(event) {
    // youtube api
    var tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    // create player object list when iframeAPI is ready
    var videoSize = $('.show-mobile').data("size");
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
            player.fullScreenButton = $(this).find('.fullscreen-button');
            player.filter = $(this).find('.youtube-player-filter');
            player.remainingTimer = $(this).find('.remaining-timer');
            player.progressBar = $(this).find('#progress-bar-' + index);
            player.progressBarController = new ProgressBar.Circle('#progress-bar-' + index, {
                strokeWidth: 4,
                easing: 'easeInOut',
                color: '#9BFFCC',
                trailColor: 'rgba(256, 256, 256, 0.33)',
                trailWidth: 4,
                svgStyle: null
            });
            players.push(player);
        });
    };

    // on each player ready
    function onPlayerReady(event) {
        player = event.target;
        if (player.index == 0) {
            player.playVideo();
        }
        updateTimerDisplay(player);
        updateProgressBar(player);
        readyPlayerSize++;
        if (readyPlayerSize == videoSize) {
            onAllPlayerReady();
        }
    }

    function updateTimerDisplay(player){
        // Update current time text display.
        checkTime = setInterval(function () {
            player.remainingTimer.text(formatTime( player.getDuration() - player.getCurrentTime() ));
        }, 500);
    }
    function formatTime(time){
        time = Math.round(time);
        var minutes = Math.floor(time / 60),
            seconds = time - minutes * 60;
        seconds = seconds < 10 ? '0' + seconds : seconds;
        return minutes + ":" + seconds;
    }
    function updateProgressBar(player){
        updateProgress = setInterval(function () {
            player.progressBarController.set((player.getCurrentTime() / player.getDuration()));
        }, 200);
    }

    // set change of play button image'
    function onPlayerStateChange(event) {
        var player = event.target;
        if (event.data === YT.PlayerState.PLAYING) {
            player.playButton.attr('src', "/assets/icon_pause");
            hideFilter(player);
        } else if (event.data === YT.PlayerState.PAUSED || event.data === event.data === YT.PlayerState.CUED) {
            player.playButton.attr('src', "/assets/icon_play");
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
            player.container.on("click", function() {
                onClickContainer(player);
            });
        });
    }

    // on click play button
    function onClickPlayButton(player) {
        if (player.getPlayerState() === 1) {
            player.pauseVideo();
        } else {
            player.playVideo();
        }
    }

    // on click quality button
    function onClickQualityButton(player) {
        var quality = player.getPlaybackQuality();
        if (quality === 'small' || quality === 'medium' || quality === 'large') {
            player.setPlaybackQuality('hd720');
        } else {
            player.setPlaybackQuality('medium');
        }
    }

    // on click fullscreen button
    function onClickFullscreenButton(player) {
        var iframeTag = player.a;
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

    // on clikc container show filter, buttons, progress-bar, timer
    function onClickContainer(player) {
        if (player.filter.is(':visible') === true && !$(event.target).hasClass("play-button")) {
            hideFilter(player);
        } else {
            showFilter(player);
        }
    }

    function showFilter(player) {
        player.filter.show();
        player.playButton.show();
        player.progressBar.show();
        player.remainingTimer.show();
        player.qualityButton.show();
        player.fullScreenButton.show();
    }
    function hideFilter(player) {
        player.filter.hide();
        player.playButton.hide();
        player.progressBar.hide();
        player.remainingTimer.hide();
        player.qualityButton.hide();
        player.fullScreenButton.hide();
    }

    // set onclick lineup buttons
    $('.artist-profile').each(function(index, lineupButton) {
        $(lineupButton).on("click", function() {
            onClickLineupButton($(this));
        });
    });

    // on click lineup button(profile)
    function onClickLineupButton(lineupButton) {
        var buttonIndex = $(lineupButton).data("index");
        var currentVideoIndex = $('#upcomings-show-mobile').data("videoIndex");
        var currentPlayer = players.filter(function(player) {
            return player.index == currentVideoIndex;
        })[0];
        var targetPlayer = players.filter(function(player) {
            return player.index == buttonIndex;
        })[0];
        var currentContainer = currentPlayer.container;
        var targetContainer = targetPlayer.container;
        var likeTrue = $(targetContainer).data("likeTrue");
        switchVideoDisplay(targetContainer, currentContainer);
        switchVideoStatus(targetPlayer, currentPlayer);
        switchLikebuttonColor(likeTrue);
        switchLikebuttonUrl(targetContainer);
        $('#upcomings-show-mobile').data("videoIndex", buttonIndex);
    }

    function switchVideoDisplay(targetContainer, currentContainer) {
        $(currentContainer).addClass("_display-none");
        $(targetContainer).removeClass("_display-none");
    }
    function switchVideoStatus(targetPlayer, currentPlayer) {
        currentPlayer.pauseVideo();
        targetPlayer.playVideo();
    }
    function switchLikebuttonColor(likeTrue) {
        if (likeTrue) {
            $('#icon-like-filled').removeClass('_display-none');
            $('#icon-like-empty').addClass('_display-none');
        } else {
            $('#icon-like-filled').addClass('_display-none');
            $('#icon-like-empty').removeClass('_display-none');
        }
    }
    function switchLikebuttonUrl(targetContainer) {
        var postClass = targetContainer.data("postClass");
        var postId = targetContainer.data("postId");
        var videoIndex = targetContainer.data("index");
        $('#video-like-button').attr("href", "/upcomings/toggle_video_like/" + postClass + "/" + postId + "/" + videoIndex);
    }
});