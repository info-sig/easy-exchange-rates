require 'open-uri'

require_relative 'hnb/exchange_rates_parser'

module HNB

  def self.url
    @url || "http://www.hnb.hr/tecajn/htecajn.htm"
  end

  def self.url= string
    @url = string
  end

  # caching is handled here because we're not so much caching the HTTP response to the client, but the API response
  # from HNB, ideally we would not do more then 2 HTTP requests per day
  def self.original_file
    ExchangeRates.cache.fetch("hnb/original") do
      open(url).read
    end
  end

  def self.today
    @today = HNB::ExchangeRatesParser.new(original_file)
    @today.parse!
    @today.to_hash
  end

end

