require "httpclient"
require "json"

class Events

  def initialize(city, state, date)
    @city = city
    @state = state
    @date = date
  end

  def events_info
    response = HTTPClient.new.get("http://api.seatgeek.com/2/events?venue.city=#{@city}&venue.state=#{@state}&datetime_local.gte=#{@date}T00:00:00&datetime_local.gte=#{@date}T11:59:59")
    JSON.parse(response.body)["events"]
  end
end
