$(document).ready(function() {
  createViewingOverlay();
  addShadowBox();
});

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
    $contentsDiv.append($("<div>").attr({id: "overlay-replace", "class": "shadowbox"}));
    $overlayContainer.append($contentsDiv);
    $("body").append($overlayContainer);
    $("#mainblock").append($("<div>").attr({id: "feedback"})); 
  }
}

function addShadowBox() {
  $(".shadowbox-link").click(function() {
  var self = $(this);
  $('#overlay-replace').html($("#" + self.attr('data-shadowbox')).html());
  $("#overlay-container").show();
  $("#overlay-content").css({"marginTop": -($("#overlay-content").height() / 2 + 50)});
  $("#overlay-container").hide();
  $('#overlay-container').fadeIn();
  return false;
  });
};