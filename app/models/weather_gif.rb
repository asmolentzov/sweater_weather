class WeatherGif
  attr_reader :location
  
  def initialize(location)
    @location = location
  end
  
  def images
    forecast = Forecast.new(location)
    weather_days = forecast.get_weather_days
    weather_days.map do |weather|
      Gif.new(weather.date, weather.summary)
    end
  end
end