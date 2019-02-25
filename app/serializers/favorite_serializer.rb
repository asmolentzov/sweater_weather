class FavoriteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location
  
  attribute :current_weather do |object|
    object.location.current_weather
  end
end
