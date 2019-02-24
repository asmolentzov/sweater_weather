class Background
  attr_reader :city, :state
  
  def initialize(location)
    split_location = location.split(',')
    @city = split_location.first
    @state = split_location.last
  end
  
  def image_url
    ImageService.new(@city, @state).get_image
  end
end