include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Tagging

class Nanoc3::Item
  def title
    return self[:title] if self[:title]

    content = compiled_content(:snapshot => :pre)
    return $1 if content =~ /<h1[^>]*>(.*)<\/h1>/i

    return identifier.split('/').last
  end
  
  def rel_url
    url_for(self).gsub(%r{^#{Regexp.escape(site.config[:base_url])}}, "")
  end
end

class Fixnum
  def ordinal_suffix
    if (11..13).include?(self % 100)
      "th"
    else
      case self.to_i % 10
      when 1; "st"
      when 2; "nd"
      when 3; "rd"
      else    "th"
      end
    end
  end
end
