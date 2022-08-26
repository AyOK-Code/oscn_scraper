require 'byebug'
module OscnScraper
  module Requestor
    # Searches for a specific case
    # @note OSCN Endpoint - https://www.oscn.net/dockets/GetCaseInformation.aspx?
    class Case < Base
      attr_reader :kwargs

      # Initialize the class
      #
      # @param [Hash] kwargs
      # @option kwargs [String] :county Name of Oklahoma county
      # @option kwargs [String] :number OSCN Case Number (Ex: CF-2020-1203)
      # @return Initialized Object
      def initialize(kwargs = {})
        super()
        @kwargs = kwargs
        valid_params?(kwargs.keys, valid_params)
      end

      # Creates class method for calling .fetch_case_by_number
      def self.fetch_case_by_number(kwargs = {})
        new(kwargs).fetch_case_by_number
      end

      # Makes request to OSCN
      #
      # @return Request data
      def fetch_case_by_number
        required_params?(kwargs.keys, required_params)
        params = {
          db: kwargs[:county].downcase,
          number: kwargs[:number]
        }
        request(concatenated_url(endpoint, params))
      end

      private

      def endpoint
        'dockets/GetCaseInformation.aspx?'
      end

      def valid_params
        %i[county number]
      end

      def required_params
        %i[county number]
      end
    end
  end
end
