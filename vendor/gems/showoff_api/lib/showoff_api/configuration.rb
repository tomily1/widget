# frozen_string_literal: true

module ShowoffApi
  # Configurator for showoff client
  class Configuration
    attr_accessor :client_id, :client_secret, :endpoint, :logger

    def initialize
      yield self if block_given?
    end
  end
end
