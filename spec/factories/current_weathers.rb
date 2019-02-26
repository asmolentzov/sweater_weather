FactoryBot.define do
  factory :current_weather do
    temperature { 1 }
    temp_feels_like { 1 }
    temp_high { 10 }
    temp_low { 1 }
    humidity { 1 }
    visibility { 1 }
    uv_index { 1 }
    summary { 'weather!' }
    summary_short { 'weather!' }
    summary_tonight { 'weather!' }
  end
end
