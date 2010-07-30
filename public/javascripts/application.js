$(document).ready(function() {
  
  // All Posts
  $(".post").hide();
  var posts = $(".post"),
      i = 0;
  (function() {
    $(posts[i++]).fadeIn('slow', arguments.callee);
  })();
  
  // Password Chroma-Hash
  
  $("input:password").chromaHash({number: 4});
  $("#username").focus();
    
});

