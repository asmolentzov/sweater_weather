require 'rails_helper'

describe "Gif API" do
  it 'returns gifs for the weather for the requested location', :vcr do
    get '/api/v1/gifs?location=denver,co'
    
    expect(response).to be_successful
    gifs = JSON.parse(response.body, symbolize_names: true)
    
    expect(gifs[:data][:attributes]).to have_key(:images)
    expect(gifs[:data][:attributes][:images].count).to eq(5)
    expect(gifs[:data][:attributes][:images].first).to have_key(:time)
    expect(gifs[:data][:attributes][:images].first).to have_key(:summary)
    expect(gifs[:data][:attributes][:images].first).to have_key(:url)
    expect(gifs[:data][:attributes][:images].first[:time]).to_not eq(gifs[:data][:attributes][:images].last[:time])
  end
end

# Idea - test for time e.g. that time is different for different days


# You will be building an API that will use weather data from the Dark Sky API in order to provide animated GIFs using the Giphy API.
# Your endpoint should accept GET requests like this:  `/api/v1/gifs?location=denver,co`
# And it should respond like this:
# ```
# {
#   data: {
#     images: [
#       {
#         time: "1541487600",
#         summary: "Mostly sunny in the morning.",
#         url: "<GIPHY_URL_GOES_HERE>"
#       },
#       {
#         time: "1541127600",
#         summary: "Partly cloudy in the evening.",
#         url: "<GIPHY_URL_GOES_HERE>"
#       },
#       {
#         time: "2381487600",
#         summary: "Snowy.",
#         url: "<GIPHY_URL_GOES_HERE>"
#       },
#       {
#         time: "1541487600",
#         summary: "Firenado",
#         url: "<GIPHY_URL_GOES_HERE>"
#       },
#       {
#         time: "1541487600",
#         summary: "Corgis because I cant think of other weather",
#         url: "<GIPHY_URL_GOES_HERE>"
#       }
#     ]     
#   }
#   copyright: "2019"
# }
# ```
# Note: Each <GIPHY_URL_GOES_HERE>  is a link to a different gif that is dependent on the weather. The time should also be different. The above example is provided for guidance about what the general structure of the data you are providing should look like.