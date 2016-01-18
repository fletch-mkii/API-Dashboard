require "./lib/geolocation"
require "./lib/weather"
require "./lib/news"
require "./lib/events"
require "sinatra/base"
require "date"
require "pry"

require "dotenv"
Dotenv.load

class Dashboard < Sinatra::Base

  def geolocation
    Geolocation.new(request.ip)
  end

  get("/") do
    @ip = geolocation.ip
    @geolocation = geolocation
    erb :dashboard
  end

  get("/weather") do
    @weather = Weather.new(geolocation.data["city"],geolocation.data["region_code"])
    @temperature = @weather.get_weather["temperature_string"]
    @cloud_cover = @weather.get_weather["weather"]

    erb :weather
  end

  get("/news") do
    @articles = News.new.top_stories

    erb :news
  end

  get("/events") do
    date = Weather.new(geolocation.data["city"],geolocation.data["region_code"]).get_weather["local_time_rfc822"]
    datetime = DateTime.parse(date)
    @events = Events.new(geolocation.data["city"],geolocation.data["region_code"], "#{datetime.year}-#{datetime.month}-#{datetime.day}")
    @all_events = @events.events_info

    erb :events
  end
end
