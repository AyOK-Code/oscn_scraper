require 'httparty'
require 'byebug'
require 'active_support/core_ext/object'
require 'logger'

module OscnScraper
  module Requestor
    # Description/Explanation of BaseScraper class
    class Base
      attr_accessor :logger, :queue

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
        if invalid_params.count.positive?
          raise OscnScraper::Errors::InvalidParam,
                "Invalid Params: #{invalid_params.join(', ')}"
        end
      end

      def required_params?(keys, required_params)
        missing_params = required_params.difference(keys)

        if missing_params.count.positive?
          raise OscnScraper::Errors::RequiredParam,
                "Missing required params: #{missing_params.join(', ')}"
        end
      end

      def base_url
        'https://www.oscn.net/'
      end
    end
  end
end
