FactoryBot.define do
  factory :location do
    city { 'City' }
    state { 'State' }
    latitude { '12.1' }
    longitude { '-12.1' }
    current_weather
  end
end
