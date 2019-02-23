class LocationService
  attr_reader :city, :state
  def initialize(city, state)
    @city = city
    @state = state
  end
  
  def get_latitude
    get_location[:lat].to_s
  end
  
  def get_longitude
    get_location[:lng].to_s
  end
  
  private
  
  def get_location
    response = conn.get do |f|
      f.params[:address] = "#{@city},#{@state}"
    end
    data = JSON.parse(response.body, symbolize_names: true)
    data[:results].first[:geometry][:location]
  end
  
  def conn
    Faraday.new(url: 'https://maps.googleapis.com/maps/api/geocode/json') do |faraday|
      faraday.params[:key] = ENV['google_geocoding_api_key']
      faraday.adapter Faraday.default_adapter
    end
  end
end