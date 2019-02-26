class Forecast
  DaysAhead = 5
  HoursAhead = 8
  
  attr_reader :city,
              :state,
              :date
              
  def initialize(location)
    location = location.split(',')
    @city = location[0].capitalize
    @state = location[1].upcase
    @location = set_location
    @date = set_date
  end
  
  def latitude
    @_latitude ||= location_service.get_latitude
  end
  
  def longitude
    @_longitude ||= location_service.get_longitude
  end
  
  def get_current_weather
    @location.current_weather
  end
  
  def get_weather_hours
    weather.weather_hours(HoursAhead)
  end
  
  def get_weather_days
    weather.weather_days(DaysAhead)
  end
  
  private
  
  def set_location
    if location = Location.find_by(city: @city, state: @state)
      @location = location
    else
      Location.create(city: @city, state: @state, latitude: latitude, longitude: longitude, current_weather: CurrentWeather.create(weather.current_weather))
    end
  end
  
  def weather
    @weather ||= Weather.new(latitude, longitude)
  end
  
  def set_date
    Time.now.strftime('%Y-%m-%d')
  end
  
  def location_service
    @location_service ||= LocationService.new(city, state)
  end
end