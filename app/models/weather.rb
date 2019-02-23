class Weather
  
  attr_reader :latitude, :longitude
  
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end
  
  def current_weather_day
    weather_data = WeatherService.new(@latitude, @longitude).get_weather
    today_weather = weather_data[:daily][:data].first
    {
      temp_feels_like: weather_data[:currently][:apparentTemperature],
      humidity: weather_data[:currently][:humidity],
      visibility: weather_data[:currently][:visibility],
      uv_index: weather_data[:currently][:uvIndex],
      summary_short: weather_data[:currently][:summary],
      summary: today_weather[:summary],
      summary_tonight: today_weather[:summary]
    }
  end
end