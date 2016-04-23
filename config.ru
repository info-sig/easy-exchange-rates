#cat config.ru
require 'rubygems'
require 'bundler'
Bundler.require(:default, (ENV['RACK_ENV']  || 'development').to_sym)

require 'json'

require_relative 'lib/exchange_rates'

run RodaApp.freeze.app