class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  set_id :object_id
  attributes :city, :state, :latitude, :longitude, :date
end
