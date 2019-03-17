class FavoriteSerializer
  include FastJsonapi::ObjectSerializer
  
  set_id do |object|
    object.location.id
  end
  
  attribute :city do |object|
    object.location.city
  end
  
  attribute :state do |object|
    object.location.state
  end
  
  attribute :current_weather do |object|
    object.location.current_weather
  end
end
