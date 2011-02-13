Array.prototype.clean = function(deleteValue) {
  for (var i = 0; i < this.length; i++) {
    if (this[i] == deleteValue) {         
      this.splice(i, 1);
      i--;
    }
  }
  return this;
};

jQuery.fn.tagList = function(tagList){
  var allTags = $(this).find("a");
  var inputTags = getTags(tagList);
  
  allTags.each(function(i,el) {
		if (checkTag(el.id, inputTags)) $(el).addClass('tagged-with');
	}).bind('click', handleTagClick);
	
	
	function checkTag(tag, array) {
		return $.inArray(tag, array) != -1;
	}
	
	function getTags(collection) {
		var str = (typeof collection !== 'string') ? collection[0].value : collection;
		return str.split(', ').clean('').clean(undefined);
	}
	
	function handleTagClick(e) {
		var self		= $(e.target),
				tagName = e.target.id;
		
		if (checkTag(tagName, inputTags)) {
			// remove from tag list
			var tagIndex = inputTags.indexOf(tagName);
			inputTags.splice(tagIndex, 1);
			tagList.val(inputTags.join(', '));
		} else {
			// add to tag list
			inputTags.push(tagName);
			tagList.val(inputTags.join(', '));
		}
		inputTags = getTags(tagList);
		self.toggleClass('tagged-with');
		return false;
	}
	
};