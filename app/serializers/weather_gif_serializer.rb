class WeatherGifSerializer
  include FastJsonapi::ObjectSerializer
  set_id :object_id
  attributes :images
end
