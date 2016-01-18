require "httpclient"
require "json"

class News

  def initialize
  end

  def top_stories
    response = HTTPClient.new.get("http://api.nytimes.com/svc/topstories/v1/technology.json?api-key=219ec1f0f4dcdedb2ce2cc7945b4935d:12:73728450")
    JSON.parse(response.body)["results"]
  end
end
