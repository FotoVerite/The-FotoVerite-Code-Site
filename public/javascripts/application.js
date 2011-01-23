// Place your application-specific JavaScript functions and classes here
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