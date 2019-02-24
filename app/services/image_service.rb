class ImageService
  
  attr_reader :city, :state
  
  def initialize(city, state)
    @city = city
    @state = state
  end
  
  def get_image(group_id = '1463451@N25')
    response = conn.get('/services/rest') do |f|
      f.params[:method] = 'flickr.groups.pools.getPhotos'
      f.params[:group_id] = group_id
      f.params[:tags] = "#{@city},#{@state}"
    end
    image_list = JSON.parse(response.body, symbolize_names: true)
    image_count = image_list[:photos][:total].to_i
    image_number = rand(0...image_count)
    image_info = image_list[:photos][:photo][image_number]
  end
  
  private
  
  def conn
    Faraday.new(url: 'https://api.flickr.com') do |faraday|
      faraday.params[:api_key] = ENV['flickr_api_key']
      faraday.params[:format] = 'json'
      faraday.params[:nojsoncallback] = 1
      faraday.adapter Faraday.default_adapter
    end
  end
end