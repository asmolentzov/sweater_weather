class GifService
  DefaultCount = 10
  
  def get_gif(phrase)
    get_random(phrase)[:images][:fixed_width][:url]
  end
  
  private
  
  def get_random(phrase)
    gifs = parse(gif_search(phrase))[:data]
    index = rand(0...DefaultCount)
    gifs[index]
  end
  
  def parse(json)
    JSON.parse(json.body, symbolize_names: true)
  end
  
  def gif_search(phrase)
    conn.get('/v1/gifs/search') do |f|
      f.params[:q] = phrase
      f.params[:limit] = DefaultCount
    end
  end
  
  def conn
    Faraday.new('https://api.giphy.com') do |faraday|
      faraday.params[:api_key] = ENV['giphy_api_key']
      faraday.adapter Faraday.default_adapter
    end
  end
end