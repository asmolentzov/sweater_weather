class Weather
  
  attr_reader :latitude, :longitude
  
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end
  
  def current_weather
    {
      temperature: current_weather_data[:temperature].round(0),
      temp_feels_like: current_weather_data[:apparentTemperature].round(0),
      temp_high: today_weather_data[:temperatureHigh].round(0),
      temp_low: today_weather_data[:temperatureLow].round(0),
      humidity: current_weather_data[:humidity],
      visibility: current_weather_data[:visibility].round(2),
      uv_index: current_weather_data[:uvIndex],
      summary: today_weather_data[:summary],
      summary_short: current_weather_data[:summary],
      summary_tonight: today_weather_data[:summary]
    }
  end
  
  def weather_hours(hours)
    (0...hours).map do |hour_index|
      weather_hour(hour_index)
    end
  end
  
  def weather_days(days)
    (0...days).map do |day_index|
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
  
  def current_weather_data
    weather_data[:currently]
  end
  
  def today_weather_data
    weather_data[:daily][:data].first
  end
  
  def weather_hour(index)
    {
      time: hourly_weather_data[index][:time],
      temperature: hourly_weather_data[index][:temperature].round(0),
      icon: hourly_weather_data[index][:icon]
    }
  end
  
  def weather_day(index)
    {
      date: Time.at(daily_weather_data[index][:time]).strftime('%Y-%m-%d'),
      summary: daily_weather_data[index][:icon],
      precip_probability: daily_weather_data[index][:precipProbability],
      precip_type: daily_weather_data[index][:precipType],
      temp_high: daily_weather_data[index][:temperatureHigh].round(0),
      temp_low: daily_weather_data[index][:temperatureLow].round(0)
    }
  end
  
  def daily_weather_data
    weather_data[:daily][:data]
  end
  
  def hourly_weather_data
    weather_data[:hourly][:data]
  end
end