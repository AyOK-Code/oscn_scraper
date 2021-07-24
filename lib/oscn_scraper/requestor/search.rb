module OscnScraper
  module Requestor
    # Mimics the search functionality of OSCN
    # @note OSCN Endpoint - https://www.oscn.net/dockets/Search.aspx
    #   returns a maximum of 500 cases
    class Search < Base
      attr_reader :kwargs

      # Initialize the class
      #
      # @param [Hash] kwargs
      # @option kwargs [String] :db description
      # @option kwargs [String] :number description
      # @option kwargs [String] :lname Last name of party
      # @option kwargs [String] :fname First name of party
      # @option kwargs [String] :mname Middle name of party
      # @option kwargs [String] :DoBMin Minimum date of birth
      # @option kwargs [String] :DoBMax Maximum date of birth
      # @option kwargs [String] :partytype Party Type
      # @option kwargs [String] :apct description
      # @option kwargs [String] :dcct description
      # @option kwargs [String] :FiledDateL description
      # @option kwargs [String] :FiledDateH description
      # @option kwargs [String] :ClosedDateL description
      # @option kwargs [String] :ClosedDateH description
      # @option kwargs [String] :iLC description
      # @option kwargs [String] :iLCType description
      # @option kwargs [String] :iYear description
      # @option kwargs [String] :iNumber description
      # @option kwargs [String] :citation description
      # @return Initialized Object
      def initialize(kwargs = {})
        super()
        @kwargs = kwargs
        valid_params?(kwargs.keys, valid_params)
      end

      # Creates class method for calling .fetch_cases
      def self.fetch_cases(kwargs = {})
        new(kwargs).fetch_cases
      end

      # Makes request to OSCN
      #
      # @return Request data
      def fetch_cases
        request(concatenated_url(endpoint, kwargs))
      end

      private

      # Defines the endpoint on OSCN
      def endpoint
        '/dockets/Results.aspx?'
      end

      # List of valid params for this class
      def valid_params
        %i[db number lname fname mname DoBMin DoBMax
           partytype apct dcct FiledDateL FiledDateH
           ClosedDateL ClosedDateH iLC iLCType iYear
           iNumber citation]
      end

      def required_params

      end
    end
  end
end
