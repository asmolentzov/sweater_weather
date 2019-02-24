class Forecast
  attr_reader :city,
              :state,
              :latitude,
              :longitude,
              :date
              
  def initialize(location)
    location = location.split(',')
    @city = location[0].capitalize
    @state = location[1].upcase
    @latitude = set_latitude
    @longitude = set_longitude
    @date = set_date
  end
  
  def get_current_weather
    weather.current_weather
  end
  
  def get_weather_hours
    weather.weather_hours
  end
  
  def get_weather_days
    weather.weather_days
  end
  
  private
  
  def weather
    @weather ||= Weather.new(@latitude, @longitude)
  end
  
  def set_latitude
    LocationService.new(city, state).get_latitude
  end
  
  def set_longitude
    LocationService.new(city, state).get_longitude
  end
  
  def set_date
    Time.now.strftime('%Y-%m-%d')
  end
end