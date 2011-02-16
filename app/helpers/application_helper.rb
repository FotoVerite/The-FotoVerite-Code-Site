module ApplicationHelper

  def url_for(options = nil)
    if options.kind_of?(Hash) && options.has_key?(:subdomain)
      options[:host] = with_subdomain(options.delete(:subdomain))
    end
    super
  end

  def with_subdomain(subdomain)
    subdomain = (subdomain || "")
    subdomain += "." unless subdomain.empty?
    [subdomain, request.domain, request.port_string].join
  end

  def truncate_on_space(text, *args)
    options = args.extract_options!
    options.reverse_merge!(:length => 30, :omission => "...")
    return text if text.blank? || text.size <= options[:length]

    new_text = truncate(text, :length => options[:length] + 1, :omission => "")
    while last = new_text.slice!(-1, 1)
      return new_text + options[:omission] if last == " "
    end
  end

  def possessive_from(word)
    word.scan(/s$/).empty? ? word + "'s" : word + "'"
  end


  def status_tag(boolean, options={})
    options[:true]        ||= ''
    options[:true_class]  ||= 'status true'
    options[:false]       ||= ''
    options[:false_class] ||= 'status false'

    if boolean
      content_tag(:span, options[:true], :class => options[:true_class])
    else
      content_tag(:span, options[:false], :class => options[:false_class])
    end
  end

  def cancel_button(link)
    "<input type='button' value='Cancel' class='cancel-button' onclick=\"window.location.href='#{link}';\" />".html_safe
  end

  def create_photo_list(parent, association, ancestors = [])
    string = ""
    parent.send(association).each_with_index do |photo, i|
      unless photo.new_record?
        url =  url_for([:staff] + ancestors + [parent, photo])
        string << "<li style='display:block;' id='#{photo.class.name.underscore.gsub("_", "-")}-#{photo.id}' class='photo-thumb #{%w{n n n n n last}[i % 6]}'>"
        string << link_to(image_tag(photo.image(:thumb)), "#", :class => "shadowbox-link", 'data-id' =>photo.id)
        string << "<small>#{link_to "X",
              url,
              :method => :delete,
              :class => "delete-image-link action"
          }
                </small>"
      end
    end
    string.html_safe
  end

end
