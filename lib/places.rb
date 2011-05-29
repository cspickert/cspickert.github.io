require 'googlestaticmap'
require 'active_support/inflector'

MAPS_DIR = "content/media/maps"

# Gets a static map for the place and saves it to a file, returning the image src url
def get_place_map_for(item, height=100, width=150)
  raise "this item has no place information!" if !item.attributes.has_key?(:place)
  
  FileUtils.mkdir_p(MAPS_DIR)
  output_path = "#{MAPS_DIR}/#{item.title.parameterize}-map.png"
  img_src = output_path.gsub(%r{^content}, "")
  return img_src if File.exists?(output_path)
  
  location = MapLocation.new(:address => item[:place][:address])
  marker = MapMarker.new(:location => location, :color => "blue")
  static_map = GoogleStaticMap.new(:center => location, :markers => [marker], :height => height, :width => width)
  
  # Request the map and save the output to a file
  static_map.get_map(output_file=output_path)
  
  img_src
end
