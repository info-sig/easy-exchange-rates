require 'active_support/cache'

module ExchangeRates

  def self.cache
    @@cache ||= ActiveSupport::Cache::MemoryStore.new(expires_in: 12 * 60 * 60)
  end

end