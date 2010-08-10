jQuery.fn.submitWithAjax = function() {
  this.live("click", function() {
	$.ajax({type: "GET", url: $(this).attr("href"), dataType: "script"});
	return false;
  });
};

$(document).ready(function() {
  
  (function() {
    $(".post").hide().each(function(index){
      $(this).delay(index * 200).fadeIn(1500, arguments.callee);
    });
  })();
  
  $(".vote").submitWithAjax();

  // Password Chroma-Hash
  
  $("input:password").chromaHash({number: 4});
  $("#username").focus();
    
});

