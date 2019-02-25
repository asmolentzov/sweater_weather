class WeatherGif
  attr_reader :time, :summary
  def initialize(date, summary)
    @time = Time.new(date).to_i
    @summary = summary
  end
end