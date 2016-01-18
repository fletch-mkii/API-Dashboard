require "httpclient"
require "json"

class Weather

  def initialize(city, state)
    @city = city
    @state = state
  end

  def get_weather
    response = HTTPClient.new.get("http://api.wunderground.com/api/ae337ac7267db9d5/conditions/q/#{@state}/#{@city}.json")
    JSON.parse(response.body)["current_observation"]
  end
end
