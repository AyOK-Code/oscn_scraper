module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Events
      attr_reader :parsed_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
      end

      def parse
        parse_events
      end

      private

      def parse_events
        events_html = parsed_html.xpath('//h2[contains(@class, "events")]/following-sibling::*[1]')
        events = { events: [] }
        if events_html.present? && events_html.first.name == 'table'
          events_html.css('tr').each_with_index do |event, i|
            next if i.zero? # Skip header || No events

            date = event.css('td font[color="green"]').text # Date
            parsed_date = DateTime.parse("#{date} -06:00", '%A, %B %-d, %Y at %l:%m %p %z')
            event_type = event.css('td')[0].children[3].text.squish # Event Type
            party_name = event.css('td')[1].text.strip
            docket = event.css('td')[2].text.strip
            events[:events] << { date: parsed_date, event_type: event_type, party_name: party_name, docket: docket }
          end
        end
        events
      end
    end
  end
end
