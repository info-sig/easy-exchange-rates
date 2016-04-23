require 'open-uri'

require_relative 'hnb/exchange_rates_parser'

module HNB

  URL = "http://www.hnb.hr/tecajn/htecajn.htm"

  def self.original_file
    ExchangeRates.cache.fetch("hnb/original") do
      open(URL).read
    end
  end

  def self.today
    HNB::ExchangeRatesParser.new(original_file).parse!
  end

end

