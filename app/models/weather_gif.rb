class WeatherGif
  attr_reader :time, :weather_summary
  def initialize(date, weather_summary)
    @time = Time.new(date).to_i
    @weather_summary = weather_summary
  end
end