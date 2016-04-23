require "test_helpers"

class HnbTest < IntegrationTest

  def expected_response
    @expected_response ||= {
      # header:
      serial_number: 79,        # first 3 chars
      date: '23042016',         # next 8 chars
      created_at: '22042016',   # next 8 chars
      number_of_records: 13,    # next 2 chars

      # a rate's row
      rate: { "num"=>578, "alpha3"=>"NOK", "unit"=>1, "buy_rate"=>0.807942, "mean_rate"=>0.810373, "sell_rate"=>0.812804 }
    }.stringify_keys
  end


  def setup
    super
    ExchangeRates.cache.clear
    HNB.url = 'test/fixtures/hnb_original.txt'
  end

  def test_original
    body = request.get('/hnb/original').body
    assert_equal open('test/fixtures/hnb_original.txt').read, body,
      'the body doesnt look good'
  end

  def test_xml
    body = request.get('/hnb/xml').body

    response = Hash.from_xml(body)['exchange_rates']

    assert_response response
  end

  def test_json
    body = request.get('/hnb/json').body
    response = JSON.parse(body)

    assert_response response
  end


  private

  def assert_response response
    assert_equal expected_response.except('rate'), response.except('rates'),
      'the response headers do not match expectations'


    chosen_rate_row = response['rates'].select{|x| x['num'] == expected_response['rate']['num'] }.first

    # fix for JSON deserialization, this is getting a bit hackish
    chosen_rate_row = Hash[ chosen_rate_row.map{|k,v| [k.gsub('-', '_'), v]} ]

    assert_equal expected_response['rate'], chosen_rate_row,
      'the rates dont match'
  end

end
