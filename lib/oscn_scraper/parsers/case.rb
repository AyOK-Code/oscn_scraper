module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Case < BaseParser
      attr_reader :parsed_html

      def initialize(parsed_html)
        @parsed_html
      end

      def parse
        # Datapoints
        # oscn_id, html, filed_at, closed_at, county_id, case_type_id, arresting_officer, scraped_at
        
        byebug
        # TODO: Include logic around parsing Case
        # TODO: Return object
      end
    end
  end
end
