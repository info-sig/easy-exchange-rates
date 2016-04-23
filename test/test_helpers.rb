require "minitest/autorun"
require "roda"
#require "json"
#require "stringio"
require "rack/test"


class IntegrationTest < Minitest::Test

  include Rack::Test::Methods

  OUTER_APP = Rack::Builder.parse_file('config.ru').first


  def app
    OUTER_APP
  end

  def request
    Rack::MockRequest.new(app)
  end

end