require 'httparty'
require 'byebug'
require 'ruby-limiter'
require 'active_support/core_ext/object'
require 'logger'

module OscnScraper
  module Requestor
    # Description/Explanation of BaseScraper class
    class Base
      extend Limiter::Mixin
      attr_accessor :logger, :queue

      def initialize
        @queue = Limiter::RateQueue.new(120, interval: 60) # Limits requests to 120 per 60 seconds change to config
        @logger = Logger.new($stdout)
      end

      def concatenated_url(endpoint, params = {})
        "#{base_url}#{endpoint}#{params.to_query}"
      end

      private

      def request(url)
        # @queue.shift
        HTTParty.get(url)
      end

      def valid_params?(keys, valid_params)
        invalid_params = keys.difference(valid_params)
        raise OscnScraper::InvalidParamError, "Invalid Params: #{invalid_params.join(', ')}" if invalid_params.count > 0
      end

      def required_param?(keys, required_params)
        missing_params = required_params.difference(keys)
        raise OscnScraper::RequiredParamError, "Missing required params: #{missing_params.join(', ')}" if missing_params.count > 0
      end

      def base_url
        'https://www.oscn.net/'
      end
    end
  end
end
