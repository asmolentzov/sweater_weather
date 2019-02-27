class Forecast
  DaysAhead = 5
  HoursAhead = 8
  
  attr_reader :city,
              :state,
              :date,
              :latitude,
              :longitude
              
  def initialize(city_state)
    city_state = city_state.split(',')
    @city = city_state[0].capitalize
    @state = city_state[1].upcase
    @latitude = set_latitude
    @longitude = set_longitude
    @date = set_date
    @location = location
  end
  
  def get_current_weather
    @location.current_weather
  end
  
  def get_weather_hours
    JSON.parse(@location.weather_hours_collection.weather_hours_data, symbolize_names: true)
  end
  
  def get_weather_days
    JSON.parse(@location.weather_days_collection.weather_days_data, symbolize_names: true)
  end
  
  private
  
  def location
    Location.find_or_create_by(city: city, state: state) do |l|
      l.latitude = set_latitude
      l.longitude = set_longitude
      l.current_weather = CurrentWeather.create(weather.current_weather)
      l.weather_days_collection = WeatherDaysCollection.create(weather_days_data: weather.weather_days(DaysAhead).to_json)
      l.weather_hours_collection = WeatherHoursCollection.create(weather_hours_data: weather.weather_hours(HoursAhead).to_json)
    end
  end
  
  def set_latitude
    @_latitude ||= location_service.get_latitude
  end
  
  def set_longitude
    @_longitude ||= location_service.get_longitude
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