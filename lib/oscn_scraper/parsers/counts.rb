module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Counts
      attr_reader :parsed_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
      end

      def parse
        parse_counts
      end

      private

      def parse_counts
        counts_html = parsed_html.css('div.CountsContainer')
        counts = { counts: [] }
        if counts_html.present?
          counts_html.each do |_event|
            counts_html.at('td:contains("Count as Filed:")')
            filed_html.children[0].text.squish.split(',')[1]
            filed_html.children[1].text
            filed_html.children[1].attribute('href').value

            counts[:counts] << {
              party_name: 'Name',
              offense_on: Date.current,
              as_filed: 'string',
              filed_statute_violation: 'link',
              disposition: 'string',
              disposition_on: '',
              diposed_statute_violation: 'string',
              plea: 'string?',
              verdict: 'string?'
            }
          end
        end
        counts
      end
    end
  end
end
