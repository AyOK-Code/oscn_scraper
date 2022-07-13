require 'byebug'

module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Events
      attr_reader :events_html

      def initialize(events_html)
        @events_html = events_html
        @events = { events: [] }
      end

      def self.parse(events_html)
        new(events_html).parse
      end

      def parse
        parse_events
      end

      private

      attr_accessor :events

      def parse_events
        return events if events_html.blank? || events_html.first.name != 'table'

        events_html.css('tbody tr').each do |event|
          build_event(event)
        end

        events
      end

      def build_event(event)
        date_string = event.css('td font[color="green"]').text # Date
        date = parsed_date(date_string)
        event_type = event.css('td')[0].children[3].text.squish # Event Type
        event_code = event.search('.//comment()').text.squish.gsub('(', '').gsub(')', '')
        party_name = event.css('td')[1].text.strip
        docket = event.css('td')[2].text.strip

        events[:events] << {
          date: date,
          event_type: event_type,
          event_code: event_code,
          party_name: party_name,
          docket: docket
        }
      end

      # TODO: move to helpers
      def parsed_date(date_string)
        DateTime.parse("#{date_string} -06:00", '%A, %B %-d, %Y at %l:%m %p %z')
      end
    end
  end
end
