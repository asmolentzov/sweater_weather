class WeatherGif
  attr_reader :time, :summary, :url
  def initialize(date, summary)
    @time = Time.parse(date).to_i
    @summary = summary
    @url = GifService.new.get_gif(summary)
  end
end