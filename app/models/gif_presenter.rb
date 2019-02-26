class GifPresenter
  attr_reader :location, :copyright
  
  def initialize(location)
    @location = location
    @copyright = Time.now.strftime('%Y')
  end
  
  def images
    weather_days.map do |weather|
      WeatherGif.new(weather[:date], weather[:summary])
    end
  end
  
  private
  
  def weather_days
    @_weather_days ||= Forecast.new(location).get_weather_days
  end
end