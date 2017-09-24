function sendClickTab(section) {
    ga('send', 'event', 'Click', 'tab', section, 0);
}

function sendClickButton(button, type) {
    ga('send', 'event', 'Click', 'button', button, type === undefined ? 0 : type);
}

function sendScrollEvent($location, url) {
    ga('send', { 'hitType': 'pageview', 'page': $location.attr("href") + url });
    console.log("full url: " + $location.attr("href") + url);
}

function sendConnectEvent(url) {
    ga('send', { 'hitType': 'pageview', 'page': url });
    console.log('url: '+url);
}