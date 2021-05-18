module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Counts
      include OscnScraper::Parsers::Helpers
      attr_reader :parsed_html, :counts_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
        @counts_html = parsed_html.css('div.CountsContainer')
        @counts = { counts: [] }
      end

      def parse
        parse_counts
      end

      private

      attr_accessor :counts

      def disposition(party_html)
        party_html.css('td font[color="red"]').text.squish.gsub('Disposed: ', '')
      end

      def disposition_on(party_html)
        disposition(party_html).match(/[0-9]{2}\/[0-9]{2}\/[0-9]{4}/).to_s
      end

      def disposition_link(party_html)
        party_html.css('td a').attribute('href')&.text
      end

      def disposition_statute(party_html)
        party_html.css('td a')&.text&.squish
      end

      def party_name(party_html)
        party_html.css('td')[1].text
      end

      def disposition_plea(party_html)
        disposition(party_html).split('.')[1]&.squish
      end

      def disposition_verdict(party_html)
        disposition(party_html).split(',')[0]&.squish
      end

      def filed_html(row)
        row.at('td:contains("Count as Filed:")')
      end

      def as_filed(row)
        filed_html(row).children[0].text.squish.split(',')[1]&.squish
      end

      def statute(row)
        filed_html(row).children[1].text
      end

      def statute_link(row)
        filed_html(row).children[1].attribute('href').value&.squish
      end

      def offense_on(row)
        filed_html(row).children[3].text.gsub('Date of Offense: ', '')
      end

      def parties_html(row)
        row.at('table:contains("Party Name")').css('tbody tr')
      end

      def parse_counts
        return if counts_html.blank?

        counts_html.each do |row|
          parties_html.each do |p|
            counts[:counts] << {
              party_name: party_name(p),
              offense_on: parse_date(offense_on),
              as_filed: as_filed(row),
              filed_statute_violation: statute(row),
              filed_statute_violation_link: statute_link(row),
              disposition: disposition(p),
              disposition_on: parse_date(disposition_on(p)),
              disposed_statute_violation: disposition_statute(p),
              disposed_statute_violation_link: disposition_link(p),
              plea: disposition_plea(p),
              verdict: disposition_verdict(p)
            }
          end
        end
      end
      counts
    end
  end
end
