FactoryBot.define do
  factory :location do
    city { 'City' }
    state { 'STATE' }
    latitude { '12.1' }
    longitude { '-12.1' }
    current_weather
    weather_hours_collection
    weather_days_collection
  end
end
