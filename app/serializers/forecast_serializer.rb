class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_id :object_id
  attributes :city, :state, :latitude, :longitude, :date
  
  attribute :current_weather do |object|
    object.get_current_weather
  end
  
  attribute :weather_hours do |object|
    object.get_weather_hours
  end
  
  attribute :weather_days do |object|
    object.get_weather_days
  end
end
