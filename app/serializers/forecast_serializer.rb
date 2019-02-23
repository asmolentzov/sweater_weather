class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_id :object_id
  attributes :city, :state, :latitude, :longitude, :date
  
  attribute :current_weather_day do |object|
    object.get_current_weather_day
  end
  
  attribute :weather_days do |object|
    object.get_weather_days
  end
end
