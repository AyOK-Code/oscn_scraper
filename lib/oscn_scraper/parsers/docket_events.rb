module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class DocketEvents
      include Helpers

      attr_reader :docket_events_html

      def initialize(docket_events_html)
        @docket_events_html = docket_events_html
        @docket_events = { docket_events: [] }
      end

      def parse
        parse_docket_events
      end

      private

      attr_accessor :docket_events

      def parse_docket_events
        docket_events_html.css('tbody tr').each do |row|
          date = sanitize_data(row.css('td')[0])
          code = sanitize_data(row.css('td')[1])
          description = sanitize_data(row.css('td')[2])
          count = sanitize_data(row.css('td')[3])
          party = sanitize_data(row.css('td')[4])
          amount = sanitize_data(row.css('td')[5])

          docket_events[:docket_events] << {
            date: Date.strptime(date, '%m-%d-%Y'),
            code: code,
            description: description,
            count: count,
            party: party,
            amount: amount
          }
        end
        docket_events
      end
    end
  end
end
