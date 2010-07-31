$(document).ready(function() {
  
  (function() {
    $(".post").hide().each(function(index){
      $(this).delay(index * 200).fadeIn(1500, arguments.callee);
    });
  })();

    

  
  
  // Password Chroma-Hash
  
  $("input:password").chromaHash({number: 4});
  $("#username").focus();
    
});

