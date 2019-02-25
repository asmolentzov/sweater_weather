class GifPresenter
  attr_reader :location
  
  def initialize(location)
    @location = location
  end
  
  def images
    forecast = Forecast.new(location)
    weather_days = forecast.get_weather_days
    weather_days.map do |weather|
      WeatherGif.new(weather[:date], weather[:icon])
    end
  end
end