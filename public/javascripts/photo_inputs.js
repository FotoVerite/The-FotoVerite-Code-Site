jQuery.fn.addImageInputBinding = function(attributeName, modelName, sortUrl){
  
   createSortable($(this), sortUrl);
   createViewingOverlay();
   var $addButton = $(this).find(".add-image-input");
   var pac =  new PhotoAttributesContainer(attributeName, modelName, $(this));
   $addButton.click(function () {
       var $fieldList = $("#" + attributeName + "_fields");
       var $input = createPhotoFileInput(pac);
       $fieldList.append($input);
       return false;
     });
   addShadowBox(pac);
   $(this).find(".remove-file-input").live("click", function() {
     pac.removeField($(this).siblings('select')[0]);
     $(this).parent().parent().remove();
     return false;
   });
   
   $(this).find(".delete-image-link").click(function () {
     var remove = confirm("Are you sure you want to remove this image?");
     if(remove) {
       $.ajax({
         url: $(this).attr('href'),
         type: "DELETE",
         dataType: "script",
         success: function(msg) {
           pac.decrementCount();
         }
       });
     }
     return false;
   });
  };
  
  function createSortable($div, sortUrl) {
    var $img = null;
    $div.find( ".photos-display-list" ).sortable(
        {
          placeholder: 'photo-thumb-placeholder',
          start: function(event, ui) {
            $a = ui.helper.children('a');
            $a.removeClass('shadowbox-link');
          },
          update: function() {
            $.post(sortUrl, $(this).sortable('serialize')); 
          },
          stop: function(event, ui) {
            $a.addClass('shadowbox-link');
          }
      });
  }
  
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
    }
  }
  
  function addShadowBox(pac) {
    pac.uploadedImages.find(".shadowbox-link").live('click', function() {
        if(!$(this).hasClass("noClick")) {
        var $img =$("<img>").attr({src: $(this).attr("href")});
        $img.load(function() {
          $("#overlay-replace").html($img);
          $("#overlay-container").show();
          $("#overlay-content").css({"marginTop": -($("#overlay-content").height() / 2)});
          $("#overlay-container").hide();
          $('#overlay-container').fadeIn();
        });
        return false;
      }
    });
  };
  
  function PhotoAttributesContainer(attributeName, modelName, $div) {
    var self = this;
    this.attributeName = attributeName;
    this.modelName = modelName;
    this.uploadedImages = $div.find(".photo-thumb");
    this.uploadFields = $div.find(".upload-fields");
    this.count = this.uploadedImages.size() +  this.uploadFields.size();
    
    this.addField = function(field) {
      self.uploadFields.push(field[0]);
      self.count++;
    };
    
    this.removeField = function(element) {
      self.uploadFields = self.uploadFields.not(element);
      self.decrementCount();
    };
    
    this.decrementCount = function() {
      self.uploadFields.find("option:last").remove();
      self.count--;
    };
    
    return this;
  };
  
  function createPhotoFileInput(pac) {
      var index = new Date().getTime();
      var name = pac.attributeName + index;
      var nameValue = pac.modelName + "[" + pac.attributeName + "][" + index + "]";
      var $input = $("<dl>");
      var $dtTag = $("<dt>");
      var $ddTag = $("<dd>");
      $dtTag.append($("<label>").attr({"for": name}).html("Image"));
      $input.append($dtTag);
      $ddTag.append($("<input>").attr({"id": name, "type": "file", "name": nameValue + "[image]"}));
      $ddTag.append(
       createPositionSelect(
         pac,
         nameValue
       )
      );
      $ddTag.append($("<a>").attr({"href": "#"}).addClass("remove-file-input action").html("&nbsp;remove"));
      $input.append($ddTag);
      return $input;
  }
  
  function createPositionSelect(pac, name) {
    var $select = $("<select>");
    $select.addClass('position-keeper');
    maximumPosition = pac.count + 1;
    pac.uploadFields.append(new Option(maximumPosition, maximumPosition));
    $select.attr({"name" : name + "[position_keeper]"});
    for (var i=1; i<= maximumPosition; i++) {
      var $option = $('<option>');
      $option.attr({"value": i, "text": i});
      if( i == maximumPosition) {
        $option.attr({"selected": "selected"});
      }
      $select.append($option);
    }
    pac.addField($select);
    return($select);
    
  }