module OscnScraper
  module Requestor
    # Party Scraper
    class Party < Base
      attr_reader :county, :oscn_id

      def initialize(county, oscn_id)
        @county = county
        @oscn_id = oscn_id
      end

      def self.fetch_party(county, oscn_id)
        new(county, oscn_id).fetch_party
      end

      def fetch_party
        endpoint = 'dockets/GetPartyRecord.aspx?'
        params = {
          db: county,
          id: oscn_id
        }
        url = "#{base_url}#{endpoint}#{params.to_query}"
        request(url)
      end
    end
  end
end
