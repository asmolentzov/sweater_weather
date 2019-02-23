class WeatherService
  attr_reader :latitude, :longitude
  
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end
  
  def get_weather
    response = conn.get("/forecast/#{ENV['darksky_api_key']}/#{@latitude},#{@longitude}") do |f|
      f.params[:exclude] = 'minutely'
    end
    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
  
  def conn
    Faraday.new("https://api.darksky.net")
  end
end