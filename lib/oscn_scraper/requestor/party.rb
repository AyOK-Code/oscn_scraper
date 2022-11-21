require 'byebug'
module OscnScraper
  module Requestor
    # Searches for a specific party
    # @note OSCN Enpoint - https://www.oscn.net/dockets/GetPartyRecord.aspx?
    class Party < Base
      attr_reader :county, :oscn_id

      # Initialize the class
      #
      # @param county [String] Name of Oklahoma County
      # @param oscn_id [Integer] OSCN id for the party
      def initialize(county, oscn_id)
        super()
        @county = county
        @oscn_id = oscn_id
      end

      # Class method to call fetch_party
      def self.fetch_party(county, oscn_id)
        new(county, oscn_id).fetch_party
      end

      # Makes request to OSCN
      #
      # @return Request data
      def fetch_party
        params = {
          db: county,
          id: oscn_id
        }
        blanks = 0
        request(concatenated_url(endpoint, params))
        
       

      end

      private

      def endpoint
        'dockets/GetPartyRecord.aspx?'
      end
    end
  end
end
