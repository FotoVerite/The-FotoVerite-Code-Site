// Place your application-specific JavaScript functions and classes here
jQuery.ajaxSetup({
 'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");}
});

// This file is automatically included by javascript_include_tag :defaults
$(document).ajaxSend(function(event, request, settings) {
if (typeof(AUTH_TOKEN) == "undefined") return;
settings.data = settings.data || "";
settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
 // Password Idea
  $("a#password_idea_link").click(function () {
    $("#getting_idea").show();
    $("#get_idea").hide();
    $.ajax({
      url: $(this).attr('href'),
      type: "GET",
      success: function(response, textStatus) {
        // response should either be the assignment_id or 'Failure'
        $("#password_idea").html(response);
        $("#getting_idea").hide();
        $("#get_idea").show();
      }
    });
    return false;
  });
  
});

jQuery.fn.delay = function(time,func){
  this.each(function(){
    setTimeout(func,time);
  });
};

// $('img.photo',this).imagesLoaded(myFunction)
// execute a callback when all images have loaded.
// needed because .load() doesn't work on cached images

// mit license. paul irish. 2010.
// webkit fix from Oren Solomianik. thx!

// callback function is passed the last image to load
//   as an argument, and the collection as `this`


$.fn.imagesLoaded = function(callback){
  var elems = this.filter('img'),
      len   = elems.length;
      
  elems.bind('load',function(){
      if (--len <= 0){ callback.call(elems,this); }
  }).each(function(){
     // cached images don't fire load sometimes, so we reset src.
     if (this.complete || this.complete === undefined){
        var src = this.src;
        // webkit hack from http://groups.google.com/group/jquery-dev/browse_thread/thread/eee6ab7b2da50e1f
        // data uri bypasses webkit log warning (thx doug jones)
        this.src = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
        this.src = src;
     }  
  }); 

  return this;
};

(function($) {
$.fn.batchImageLoad = function(options) {
	var images = $(this);
	var originalTotalImagesCount = images.size();
	var totalImagesCount = originalTotalImagesCount;
	var elementsLoaded = 0;

	// Init
	$.fn.batchImageLoad.defaults = {
		loadingCompleteCallback: null, 
		imageLoadedCallback: null
	}
    var opts = $.extend({}, $.fn.batchImageLoad.defaults, options);
		
	// Start
	images.each(function() {
		// The image has already been loaded (cached)
		if ($(this)[0].complete) {
			totalImagesCount--;
			if (opts.imageLoadedCallback) opts.imageLoadedCallback(elementsLoaded, originalTotalImagesCount);
		// The image is loading, so attach the listener
		} else {
			$(this).load(function() {
				elementsLoaded++;
				
				if (opts.imageLoadedCallback) opts.imageLoadedCallback(elementsLoaded, originalTotalImagesCount);

				// An image has been loaded
				if (elementsLoaded >= totalImagesCount)
					if (opts.loadingCompleteCallback) opts.loadingCompleteCallback();
			});
			$(this).error(function() {
				elementsLoaded++;
				
				if (opts.imageLoadedCallback) opts.imageLoadedCallback(elementsLoaded, originalTotalImagesCount);
					
				// The image has errored
				if (elementsLoaded >= totalImagesCount)
					if (opts.loadingCompleteCallback) opts.loadingCompleteCallback();
			});
		}
	});

	// There are no unloaded images
	if (totalImagesCount <= 0)
		if (opts.loadingCompleteCallback) opts.loadingCompleteCallback();
};
})(jQuery);