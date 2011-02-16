module Staff::PhotosHelper
  
  def display_photo(photo, size ="display")
    photo.text_only? ? photo.description.html_safe : image_tag(photo.image(size.to_sym))
  end
end
