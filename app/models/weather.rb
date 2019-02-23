class Weather
  
  attr_reader :latitude, :longitude
  
  def initialize(latitude, longitude, days_ahead = 5)
    @latitude = latitude
    @longitude = longitude
    @days_ahead = days_ahead
  end
  
  def current_weather_day
    {
      temp_feels_like: weather_data[:currently][:apparentTemperature].round(0),
      humidity: weather_data[:currently][:humidity],
      visibility: weather_data[:currently][:visibility].round(2),
      uv_index: weather_data[:currently][:uvIndex],
      summary: today_weather[:summary],
      summary_short: weather_data[:currently][:summary],
      summary_tonight: today_weather[:summary]
    }
  end
  
  def weather_days
    (0...@days_ahead).map do |day_index|
      weather_day(day_index)
    end
  end
  
  private
  
  def weather_service
    @weather_service ||= WeatherService.new(@latitude, @longitude)
  end
  
  def weather_data
    @weather_data ||= weather_service.get_weather
  end
  
  def today_weather
    weather_data[:daily][:data].first
  end
  
  def weather_day(index)
    {
      date: Time.at(weather_data[:daily][:data][index][:time]).strftime('%Y-%m-%d'),
      summary: weather_data[:daily][:data][index][:icon],
      precip_probability: weather_data[:daily][:data][index][:precipProbability],
      temp_high: weather_data[:daily][:data][index][:temperatureHigh].round(0),
      temp_low: weather_data[:daily][:data][index][:temperatureLow].round(0)
    }
  end
end