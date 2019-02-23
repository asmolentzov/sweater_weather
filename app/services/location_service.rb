class LocationService
  attr_reader :city, :state
  def initialize(city, state)
    @city = city
    @state = state
  end
end