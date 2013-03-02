/*
 * Say Hello
 */
var buttonListener = function(event) {
    if (event == "DOUBLE") {
        karotz.tts.stop();
        exit();
    }
    else {
      var message = "Hello";

      karotz.tts.start(message, "en", function() {});
    }
    return true;
}

var start = function(data) {
    karotz.button.addListener(buttonListener);
}

