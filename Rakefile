# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace 'weather' do
  desc "Requests and loads current weather info"
  task update_current: :environment do
    Location.all.each do |location|
      weather = Weather.new(location.latitude, location.longitude)
      location.current_weather.update(weather.current_weather)
    end
  end
  desc 'Requests and loads weather days'
  task update_days: :environment do
    Location.all.each do |location|
      weather = Weather.new(location.latitude, location.longitude)
      location.weather_days_collection.update(weather_days_data: weather.weather_days(5).to_json)
    end
  end
  desc 'Requests and loads weather hours'
  task update_hours: :environment do
    Location.all.each do |location|
      weather = Weather.new(location.latitude, location.longitude)
      location.weather_hours_collection.update(weather_hours_data: weather.weather_hours(8).to_json)
    end
  end
end
