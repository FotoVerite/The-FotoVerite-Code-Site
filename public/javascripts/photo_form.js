jQuery.photoFromLink = function(baseUrl){
  
   createViewingOverlay();
   addShadowBox(baseUrl);
   
};
  
function createViewingOverlay() {
  if($("#overlay").length == 0) {
    var $overlayContainer  = $("<div>").attr({id: "overlay-container"});
    $overlayContainer.append($("<div>").attr({id: "overlay"}));
    var $contentsDiv = $("<div>").attr({id: "overlay-content"});
    var $closeLink = $("<a>").html("X").attr({id: "overlay-close-link"});
    $closeLink.click(function() {
      $overlayContainer.fadeOut("slow");
    });
    $contentsDiv.append($closeLink);
    $contentsDiv.append($("<div>").attr({id: "overlay-replace"}));
    $overlayContainer.append($contentsDiv);
    $("body").append($overlayContainer);
    $("#mainblock").append($("<div>").attr({id: "feedback"})); 
  }
}

function addShadowBox(baseUrl) {
  $(".shadowbox-link").live('click', function() {
  var self = $(this);
  $('#overlay-replace').load(baseUrl + $(this).attr("data-id") + "/edit", function() {
    $("#overlay-container").show();
    $("#overlay-content").css({"marginTop": -($("#overlay-content").height() / 2)});
    $("#overlay-container").hide();
    $('#overlay-container').fadeIn();
    $(this).find('form').submit(function() {
      $.ajax({
        type: 'PUT',
        url: $(this).attr('action'),
        data: $(this).serialize(),
        dataType: 'script',
        success: function(response) {
          feedback('positive', "Photo Updated");
          $('#overlay-container').fadeOut();
        },
        error: function(response) {
          feedback('negative', "An unknown error occurred");
        }
      });
      return false;
    });
  });
  return false;
  });
};

// Display a message inside the #feedback container div
function feedback(klass, message) {
  var msg = $('<span class="' + klass + '">' + message + '</span>');
  msg.css('display', 'none');
  $('#feedback').html(msg);
  msg.fadeIn(500).delay(2000, function() { msg.fadeOut(1000); });
}
  
