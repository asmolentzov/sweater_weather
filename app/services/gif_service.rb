class GifService
  def get_gif(phrase)
    parse(gif_search(phrase))[:data].first[:images][:fixed_width][:url]
  end
  
  private
  
  def parse(json)
    JSON.parse(json.body, symbolize_names: true)
  end
  
  def gif_search(phrase)
    conn.get('/v1/gifs/search') do |f|
      f.params[:q] = phrase
      f.params[:limit] = 1
    end
  end
  
  def conn
    Faraday.new('https://api.giphy.com') do |faraday|
      faraday.params[:api_key] = ENV['giphy_api_key']
      faraday.adapter Faraday.default_adapter
    end
  end
end