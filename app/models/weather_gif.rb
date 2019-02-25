class WeatherGif
  attr_reader :time, :summary
  def initialize(date, summary)
    @time = Time.new(date).to_i
    @summary = summary
  end
  
  def url
    conn = Faraday.new('https://api.giphy.com') do |faraday|
      faraday.params[:api_key] = ENV['giphy_api_key']
      faraday.adapter Faraday.default_adapter
    end
    
    response = conn.get('/v1/gifs/search') do |f|
      f.params[:q] = summary
      f.params[:limit] = 1
    end
    
    raw_gifs = JSON.parse(response.body, symbolize_names: true)
    raw_gifs[:data].first[:images][:fixed_width][:url]
  end
end