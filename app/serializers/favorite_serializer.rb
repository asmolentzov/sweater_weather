class FavoriteSerializer
  include FastJsonapi::ObjectSerializer
  attribute :location do |object|
    "#{object.location.city}, #{object.location.state}"
  end
  
  attribute :current_weather do |object|
    object.location.current_weather
  end
end
