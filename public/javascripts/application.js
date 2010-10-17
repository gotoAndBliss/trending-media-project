jQuery.fn.submitWithAjax = function() {
  this.live("click", function() {
	$.ajax({type: "GET", url: $(this).attr("href"), dataType: "script"});
	return false;
  });
};

$(document).ready(function() {
  
  // Post Animation 
  
  (function() {
    $(".post").hide().each(function(index){
      $(this).delay(index * 200).fadeIn(1500, arguments.callee);
    });
  })();
  
  $(".vote").submitWithAjax();

  // Password Chroma-Hash
  
  $("input:password").chromaHash({number: 4});
  $("#username").focus();

  // Link Posts
  
  var toggleTextLink = function() {
    $(this).unbind('click', toggleTextLink);
    if ($('#post_type_true').attr('checked') == true) {
      $('#post_type_true').attr('checked', false);
    } else if ($('#post_type_true').attr('checked') == false) {
      $('#post_type_true').attr('checked', true);
    }
    $(".text_link_toggle").not(this).bind('click', toggleTextLink);
    $(".text_link_toggle").not(this).unwrap();
    $(this).wrap("<div class='selected-post-nav' />")
    $(".text_link").toggle("slow");
  };
  $(".text_link_toggle:last").bind('click', toggleTextLink );
  $(".text_link_toggle:first").wrap("<div class='selected-post-nav' />")

});

