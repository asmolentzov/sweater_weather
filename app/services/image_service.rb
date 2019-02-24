class ImageService
  
  attr_reader :city, :state
  Project_weather_group_id = '1463451@N25'
  
  def initialize(city, state)
    @city = city
    @state = state
  end
  
  def get_image
    "https://farm#{random_image[:farm]}.staticflickr.com/#{random_image[:server]}/#{random_image[:id]}_#{random_image[:secret]}_b.jpg"
  end
  
  private
  
  def random_image
    @random_image ||= get_image_list[:photo][random_image_number]
  end
  
  def get_image_list(group_id = Project_weather_group_id)
    @response ||= conn.get('/services/rest') do |f|
      f.params[:method] = 'flickr.groups.pools.getPhotos'
      f.params[:group_id] = group_id
      f.params[:tags] = "#{@city},#{@state}"
    end
    JSON.parse(@response.body, symbolize_names: true)[:photos]
  end
  
  def random_image_number
    image_count = get_image_list[:total].to_i
    rand(0...image_count)
  end
  
  def conn
    Faraday.new(url: 'https://api.flickr.com') do |faraday|
      faraday.params[:api_key] = ENV['flickr_api_key']
      faraday.params[:format] = 'json'
      faraday.params[:nojsoncallback] = 1
      faraday.adapter Faraday.default_adapter
    end
  end
end