module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Parties
      attr_reader :parsed_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
        @parties = { parties: [] }
      end

      def parse
        parse_parties
      end

      private

      attr_accessor :parties

      def parse_parties
        parties_html = parsed_html.xpath('//h2[contains(@class, "party")]/following-sibling::p[1]')
        return parties if parties_html.blank?

        parties_html.first.css('a').each do |link|
          build_parties(link)
        end
        parties
      end

      def build_parties(link)
        parties[:parties] << {
          name: link.text.strip,
          link: link.attributes['href'].value,
          party_type: link.xpath('following-sibling::node()').first.text.gsub(',', '').squish
        }
      end
    end
  end
end
