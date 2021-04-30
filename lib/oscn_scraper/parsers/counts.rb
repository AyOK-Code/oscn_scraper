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

      def parse_date(date)
        begin
          Date.strptime(date, '%m/%d/%Y')
        rescue Date::Error
          ap date
        end
      end

      def parse_counts
        counts_html = parsed_html.css('div.CountsContainer')
        counts = { counts: [] }
        if counts_html.present?
          counts_html.each do |_event|
            filed_html = counts_html.at('td:contains("Count as Filed:")')
            as_filed = filed_html.children[0].text.squish.split(',')[1]
            statute = filed_html.children[1].text
            statute_link = filed_html.children[1].attribute('href').value
            offense_on = filed_html.children[3].text.gsub('Date of Offense: ', '')

            parties_html = counts_html.at('table:contains("Party Name")').css('tbody tr')

            parties_html.each_with_index do |p, i|
              party_name = p.css('td')[1].text
              disposition = p.css('td font[color="red"]').text.squish.gsub('Disposed: ', '')
              disposition_on = disposition.match(/[0-9]{2}\/[0-9]{2}\/[0-9]{4}/).to_s
              disposition_link = p.css('td a').attribute('href')&.text
              disposition_statute = p.css('td a')&.text&.squish
              disposition_plea = disposition.split('.')[1]&.squish
              disposition_verdict = disposition.split(',')[0]&.squish

              counts[:counts] << {
                party_name: party_name,
                offense_on: parse_date(offense_on),
                as_filed: as_filed&.squish,
                filed_statute_violation: statute,
                filed_statute_violation_link: statute_link,
                disposition: disposition,
                disposition_on: parse_date(disposition_on),
                disposed_statute_violation: disposition_statute,
                disposed_statute_violation_link: disposition_link&.squish,
                plea: disposition.split('.')[1]&.squish,
                verdict: disposition_verdict
              }
            end
          end
        end
        counts
      end
    end
  end
end
