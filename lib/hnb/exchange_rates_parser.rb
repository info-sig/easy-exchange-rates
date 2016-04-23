module HNB
  class ExchangeRatesParser

    attr_accessor :raw

    # {"Code"=>"124", "Name"=>"CAD", "Unit"=>"1", "BuyRateCache"=>"0,000000", "BuyRateForeign"=>"5,250048", "MeanRate"=>"5,265846", "SellRateForeign"=>"5,281644", "SellRateCache"=>"0,000000"}
    attr_accessor :rates

    attr_accessor :header
    attr_accessor :serial_number, :created_at, :date, :number_of_records

    def initialize(raw, options = {})
      @raw = raw
    end

    def parse!
      require 'open-uri'
      
      table = raw.split("\r\n")          # split raw file into an array of lines (the table)

      self.header = table[0]
      self.serial_number = header[0...3].to_i
      self.created_at = header[3...11]
      self.date   = header[11...19]
      self.number_of_records = header[19..21].to_i

      self.rates = table[1..-1].         # skip the first line & map:
        map do |line|
          columns = line.split(/ +/)     # split each line into 4 columns: i.e.: ["036AUD001", "5,167485", "5,183034", "5,198583"]

          currency_num    = columns[0][0...3].to_i
          currency_alpha3 = columns[0][3...6]
          currency_unit   = columns[0][6...9].to_i

          buy_rate  = to_f columns[1]
          mean_rate = to_f columns[2]
          sell_rate = to_f columns[3]

          {
            'num'    => currency_num,
            'alpha3' => currency_alpha3,
            'unit'   => currency_unit,
            'buy-rate'  => buy_rate,
            'mean-rate' => mean_rate,
            'sell-rate' => sell_rate
          }
        end
    end

    def to_hash
      {
        serial_number: serial_number,
        date: date,
        created_at: created_at,
        number_of_records: number_of_records,
        rates: rates
      }
    end


    private

    def to_f string
      string.gsub(',', '.').to_f
    end

  end
end
