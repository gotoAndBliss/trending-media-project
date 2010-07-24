$(document).ready(function() {
  $(".post").hide();
  var posts = $(".post"),
      i = 0;
  (function() {
    $(posts[i++]).fadeIn('slow', arguments.callee);
  })();
});

