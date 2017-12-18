require 'marvel/api/errors'

module Marvel
  module Api
    class Resource

      attr_accessor :response_hash
      attr_reader :raw_client

      def initialize(response_hash, raw_client)
        @response_hash, @raw_client = response_hash, raw_client
      end

      def [](key)
        return response_hash[key]
      end

      def []=(key, value)
        return response_hash[key] = value
      end

    end
  end
end