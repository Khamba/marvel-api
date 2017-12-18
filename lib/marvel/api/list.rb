require 'marvel/api/errors'

module Marvel
  module Api
    class List

      attr_accessor :response_hash, :offset, :limit
      attr_reader :raw_client, :total

      def initialize(response_hash, raw_client)
        @response_hash, @raw_client = response_hash, raw_client
        @offset = response_hash['offset'].to_i
        @limit = response_hash['limit'].to_i
        @total = response_hash['total'].to_i
      end

      def next
        raw_client.characters(offset: offset+limit)
      end

      def prev
        raw_client.characters(offset: offset+limit)
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