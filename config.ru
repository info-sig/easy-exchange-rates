#cat config.ru
require 'rubygems'
require 'bundler'
Bundler.require(:default, (ENV['RACK_ENV']  || 'development').to_sym)

require 'json'

require_relative 'lib/exchange_rates'
require_relative 'lib/hnb'


class App < Roda
  route do |r|
    # GET / request
    r.root do
      "Hello World"
    end

    # /hello branch
    r.on "hnb" do
      # /hello/original
      r.on "original" do
        response.headers['Content-Type'] = 'text/plain;charset=UTF-8'
        HNB.original_file
      end

      # /hnb/xml request
      r.on "xml" do
        response.headers['Content-Type'] = 'application/xml'
        ExchangeRates.cache.fetch('hnb/today.xml') do
          HNB.today.to_xml(root: 'exchange-rates')
        end
      end

      # /hnb/json request
      r.on "json" do
        response.headers['Content-Type'] = 'application/json'
        ExchangeRates.cache.fetch('hnb/today.json') do
          HNB.today.to_json
        end
      end
    end
  end
end

run App.freeze.app