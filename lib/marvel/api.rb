require "marvel/api/version"
require "httparty"
require "marvel/api/errors"
require "marvel/api/list"
require "marvel/api/resource"

module Marvel
  module Api

    class Client
      include HTTParty
      format :json
      base_uri 'https://gateway.marvel.com/v1/public/'

      attr_reader :apikey, :private_key

      def initialize(options = {})
        validate_keys_presence(options)
        @apikey = options[:apikey]
        @private_key = options[:private_key]
      end

      def characters(options = {})
        response = send_request('/characters', options)
        return Marvel::Api::List.new(response.parsed_response, self)
      end

      def character(id, options={})
        response = send_request("/characters/#{id}", options)
        return Marvel::Api::Resource.new(response.parsed_response, self)
      end

      private

        def send_request(path, options={}, format=:json)
          timestamp = Time.now.to_s
          options.merge!(ts: timestamp, hash: hash(timestamp), apikey: @apikey)
          response = self.class.get(path, query: options, format: format)
          validate_response(response)
        end

        def validate_keys_presence(options)
          unless options[:apikey] and options[:private_key]
            raise Marvel::Api::MissingKeyError
          end
        end

        def validate_response(response)
          if response.code == 200
            return response
          else
            puts response
            raise InvalidRequestError
          end
        end

        def hash(timestamp)
          Digest::MD5.hexdigest( timestamp + private_key + apikey )
        end

    end

  end
end
