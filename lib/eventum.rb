require "eventum/version"
require "eventum/configurable"
require "eventum/connection"
require "eventum/api"
require "eventum/client"
require "eventum/client/streams"
require "eventum/client/events"

# Ruby client for the Event Store API
module Eventum
  class << self
    include Eventum::Configurable

    # Alias for {Eventum::Client.new} using module configurations
    #
    # @yield [Eventum::Client]
    #   A configurable object
    #
    # @example
    #   Eventum.new do |config|
    #     config.adapter = :excon
    #     config.host = "http://localhost"
    #     config.port = 2121
    #   end
    #
    # @return [Eventum::Client]
    #
    # @api public
    def new
      client = Eventum::Client.new do |config|
        config.adapter = adapter
        config.host = host
        config.port = port
      end

      yield client if block_given?

      client
    end
  end
end
