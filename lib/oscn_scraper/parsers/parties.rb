module OscnScraper
  module Parsers
    # Description/Explanation of Case class
    class Parties
      attr_reader :parties_html

      def initialize(parties_html)
        @parties_html = parties_html
        @parties = { parties: [] }
      end

      def self.parse(parties_html)
        new(parties_html).parse
      end

      def parse
        parse_parties
      end

      private

      attr_accessor :parties

      def parse_parties
        return parties if parties_html.blank?

        parties_html.css('a').each do |link|
          byebug
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
