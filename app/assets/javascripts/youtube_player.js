document.addEventListener("DOMContentLoaded", function(event) {
    // youtube api
    var tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    var firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    // create player object list when iframeAPI is ready
    window.onYouTubeIframeAPIReady = function() {
        $('.show-video-container-js').each(function() {
            var id = $(this).data("playerId");
            var player = new YT.Player('youtube-player-' + id, {
                events: {
                    'onReady': onPlayerReady,
                    'onStateChange': onPlayerStateChange,
                    'onPlaybackQualityChange': onPlaybackQualityChange
                }
            });
            player.id = id;
            player.autoplay = $(this).data('autoplay');
            player.container = $(this);
            player.playButton = $(this).find('.play-button');
            player.qualityButton = $(this).find('.hd-button');
            player.fullScreenButton = $(this).find('.fullscreen-button');
            player.filter = $(this).find('.youtube-player-filter');
            player.remainingTimer = $(this).find('.remaining-timer');
            player.progressBar = $(this).find('#progress-bar-' + id);
            player.progressLeft = $(this).find('#progress-left');
            player.progressRight = $(this).find('#progress-right');
            if (player.progressBar.length) {
                player.progressBarController = new ProgressBar.Circle('#progress-bar-' + id, {
                    strokeWidth: 4,
                    easing: 'easeInOut',
                    color: '#9BFFCC',
                    trailColor: 'rgba(256, 256, 256, 0.33)',
                    trailWidth: 4,
                    svgStyle: null
                });
            }
            players.push(player);
        });
    };
});

var players = [];
var readyPlayerSize = 0;

// on each player ready
function onPlayerReady(event) {
    player = event.target;
    updateTimerDisplay(player);
    if (player.progressBar.length) {
        updateProgressBar(player);
    }
    if (player.autoplay) {
        player.playVideo();
    }
    readyPlayerSize++;
    var videoSize = $('.show-video-container-js').length;
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
    } else if (event.data === YT.PlayerState.PAUSED || event.data === YT.PlayerState.BUFFERING || event.data === YT.PlayerState.CUED) {
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
// TODO: how to move these methods into onPlayerReady()
function onAllPlayerReady() {
    players.forEach(function(player){
        player.playButton.on("click", function() {
            onClickPlayButton(player);
        });
        player.progressLeft.on("dblclick", function () {
            onDoubleclickProgress(player, 'left');
        });
        player.progressRight.on("dblclick", function () {
            onDoubleclickProgress(player, 'right');
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

    // set onclick lineup buttons
    $('.artist-profile').each(function(index, lineupButton) {
        $(lineupButton).on("click", function() {
            onClickLineupButton($(this));
        });
    });
}

// on click play button
function onClickPlayButton(player) {
    if (player.getPlayerState() === YT.PlayerState.PLAYING) {
        player.pauseVideo();
    } else {
        player.playVideo();
    }
}

// on dblclick progress time
function onDoubleclickProgress(player, dir) {
    var curTime = player.getCurrentTime();
    console.log("double tap! " + curTime);

    if (dir === 'left') {
        player.seekTo(curTime - 10);
    } else {
        player.seekTo(curTime + 10);
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

// on click container show filter, buttons, progress-bar, timer
function onClickContainer(player) {
    if (player.filter.is(':visible') === true &&
        event.target != player.playButton[0] &&
        event.target != player.qualityButton[0] &&
        event.target != player.fullScreenButton[0]) {
        hideFilter(player);
    } else {
        showFilter(player);
    }
}

function showFilter(player) {
    player.filter.show();
    player.playButton.show();
    if (player.progressBar) {
        player.progressBar.show();
    }
    player.remainingTimer.show();
    player.qualityButton.show();
    player.fullScreenButton.show();
}
function hideFilter(player) {
    player.filter.hide();
    player.playButton.hide();
    if (player.progressBar) {
        player.progressBar.hide();
    }
    player.remainingTimer.hide();
    player.qualityButton.hide();
    player.fullScreenButton.hide();
}

// on click lineup button(profile)
var currentVideoId = "main_video";
function onClickLineupButton(lineupButton) {
    var buttonId = $(lineupButton).data("buttonId");
    var currentPlayer = players.filter(function(player) {
        return player.id == currentVideoId;
    })[0];
    var targetPlayer = players.filter(function(player) {
        return player.id == buttonId;
    })[0];
    var currentContainer = currentPlayer.container;
    var targetContainer = targetPlayer.container;
    var likeTrue = $(targetContainer).data("likeTrue");
    switchVideoDisplay(targetContainer, currentContainer);
    switchVideoStatus(targetPlayer, currentPlayer);
    switchLikebuttonColor(likeTrue);
    switchLikebuttonUrl(targetContainer);
    currentVideoId = buttonId;
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
    var player_id = targetContainer.data("playerId");
    $('#video-like-button').attr("href", "/feeds/toggle_like/" + player_id);
}
