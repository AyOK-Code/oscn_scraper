module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class DocketEvents
      attr_reader :parsed_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
      end

      def parse
        parse_docket_events
      end

      private

      def parse_docket_events
        { docket_events: [] }
      end
    end
  end
end
