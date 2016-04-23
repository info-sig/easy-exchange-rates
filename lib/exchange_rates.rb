require 'active_support/cache'
require 'active_support/core_ext/hash'

require_relative 'hnb'
require_relative 'roda_app'

module ExchangeRates

  def self.cache
    @@cache ||= ActiveSupport::Cache::MemoryStore.new(expires_in: 12 * 60 * 60)
  end

end