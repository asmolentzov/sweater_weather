class GifPresenter
  attr_reader :location, :copyright
  
  def initialize(location)
    @location = location
    @copyright = Time.now.strftime('%Y')
  end
  
  def images
    forecast = Forecast.new(location)
    weather_days = forecast.get_weather_days
    weather_days.map do |weather|
      WeatherGif.new(weather[:date], weather[:summary])
    end
  end
end