module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Parties
      attr_reader :parsed_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
      end

      def parse
        parse_parties
      end

      private

      def parse_parties
        parties_html = parsed_html.xpath('//h2[contains(@class, "party")]/following-sibling::p[1]')
        parties = { parties: [] }
        if parties_html.present?
          parties_html.first.css('a').each do |link|
            parties[:parties] << {
              name: link.text.strip,
              link: link.attributes['href'].value,
              party_type: link.xpath('following-sibling::node()').first.text.gsub(',', '').squish
            }
          end
        end
        parties
      end
    end
  end
end
