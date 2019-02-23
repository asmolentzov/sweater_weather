class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :city, :state, :latitude, :longitude, :date
end
