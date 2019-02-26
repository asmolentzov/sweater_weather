FactoryBot.define do
  factory :location do
    city { 'City' }
    state { 'STATE' }
    latitude { '12.1' }
    longitude { '-12.1' }
    current_weather
  end
end
