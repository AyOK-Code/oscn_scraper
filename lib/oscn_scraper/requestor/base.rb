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

      def params
        {
          db: county,
          number: number,
          lname: last_name,
          fname: first_name,
          mname: middle_name,
          DoBMin: dob_min,
          DoBMax: dob_max,
          partytype: party_type,
          apct: appellate_case_type,
          dcct: district_case_type,
          FiledDateL: filed_after,
          FiledDateH: filed_before,
          ClosedDateL: closed_after,
          ClosedDateH: closed_before,
          iLC: app_only_court,
          iLCType: app_only_case_type,
          iYear: app_only_filing_year,
          iNumber: app_only_number,
          citation: citation
        }
      end

      def invalid_params?(_keys)
        rails OscnScraper::InvalidParamError, 'param'
      end

      def valid_params
        %i[db number lname fname mname DoBMin DoBMax
           partytype apct dcct FiledDateL FiledDateH
           ClosedDateL ClosedDateH iLC iLCType iYear
           iNumber citation]
      end

      def missing_param?(keys)

        raise OscnScraper::MissingParamsError, "missing required param: county" if kwargs[:county].blank?
        raise OscnScraper::MissingParamsError, 'missing required param: case_number' if kwargs[:case_number].blank?
      end

      def base_url
        'https://www.oscn.net/'
      end
    end
  end
end
