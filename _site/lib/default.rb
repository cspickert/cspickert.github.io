include Nanoc3::Helpers::Blogging
include Nanoc3::Helpers::Tagging
include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

module Nanoc3::Helpers::Rendering
  def link_for_tag(tag, base_url)
    %[<a href="#{base_url}#{tag}/" rel="tag">#{tag}</a>]
  end
end

class Nanoc3::Item
  def title
    return self[:title] if self[:title]

    content = compiled_content(:snapshot => :pre)
    return $1 if content =~ /<h1[^>]*>(.*)<\/h1>/i

    return identifier.split('/').last
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
