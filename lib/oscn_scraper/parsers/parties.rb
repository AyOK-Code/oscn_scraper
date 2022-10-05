require 'byebug'
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
        byebug
        return parties if parties_html.blank?
        if !parties_html.css('a').empty?
             parties_html.css('a').each do |link|
              build_parties(link)
             end
        end
      if !parties_html.css('p').empty?
        parties_html.css('p').each do |element|
          if !element.text.blank?
         build_parties_text(element)
          end
        end
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
      def build_parties_text(element)
        parts = element.text.split(",\r\n")
        parties[:parties] << {
          name: parts[0].strip,
          party_type:parts[1].squish
        }
      end
    end
  end
end
