require "test_helpers"

class HnbTest < IntegrationTest

  def setup
    super
    ExchangeRates.cache.clear
    HNB.url = 'test/fixtures/hnb_original.txt'
    @expected_body = open('test/fixtures/hnb_original.txt').read
  end

  def test_original
    assert_equal @expected_body, request.get('/hnb/original').body
  end

  def test_xml
    assert_equal @expected_body, request.get('/hnb/xml').body
  end

  def test_json
    assert_equal @expected_body, request.get('/hnb/json').body
  end

end
