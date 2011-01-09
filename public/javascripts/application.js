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

  // Toggle Advertisement


  // Link Posts
  
  var toggleTextLink = function() {
    $(this).unbind('click', toggleTextLink);
    if ($('#post_is_link').attr('checked') == true) {
      $('#post_is_link').attr('checked', false);
    } else if ($('#post_is_link').attr('checked') == false) {
      $('#post_is_link').attr('checked', true);
    }
    $(".text_link_toggle").not(this).bind('click', toggleTextLink);
    $(".text_link_toggle").not(this).unwrap();
    $(this).wrap("<div class='selected-post-nav' />")
    $(".text_link").toggle("slow");
  };
  if ($("#post_text").val() == "") {
    $(".text_link_toggle:last").bind('click', toggleTextLink );
    $(".text_link_toggle:first").wrap("<div class='selected-post-nav' />")
  } else {
    $('#post_is_link').attr('checked', false);
    $(".text_link").toggle();
    $(".text_link_toggle:first").bind('click', toggleTextLink );
    $(".text_link_toggle:last").wrap("<div class='selected-post-nav' />")
  };

  $(".comment").live("click", function() {
    if($(this).next().next().is(":visible")) {
    $(this).next().next().slideUp("slow");
    } else {
      $(this).next().next().slideDown("slow");
    }
    return false;
  });
  
  $(".play_movie").click(function(){
    var playBtn = $(this)
    $(this).parent().parent().children(".movie_container").toggle("slow", function(){
      if (playBtn.css("background-position") == "0% 0%"){
        playBtn.css("background-position", "0 -31px");
      } else {
        playBtn.css("background-position", "0% 0%");
      };
    });
    return false;
  });
  
  $(".text_link").bind("blur focusout", function(){
    url = $("#post_url").val();
    $.ajax({type: "GET", url: "/posts/load_images?url=" + url, dataType: "script"});
		return false;
  });
  
  $(".category-choice label").click(function(){
    $(".category-choice label").not(this).css("background","#9B4545");
    $(this).css("background", "black");
  });
  

});

