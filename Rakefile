# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc "Requests and loads current weather info"
task update_current_weather: :environment do
  Location.all.each do |location|
    weather = Weather.new(location.latitude, location.longitude).current_weather
    location.current_weather.update(weather)
  end
end