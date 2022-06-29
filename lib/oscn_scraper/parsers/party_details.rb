require 'byebug'
module OscnScraper
  module Parsers
    # parses Party Details and returns object with them
    class PartyDetails
      def initialize(html_doc)
        @html_doc = html_doc
        @details = {
          personal: {
            record_date: '1/1/1/1',
            martial_status: nil,
            birthday: nil,
            birth_city: nil,
            birth_place: nil
          },

          address: {
            record_date: '1/1/1/1',
            status: nil,
            type: nil,
            address: nil
          }

        }
      end

      # why?
      def self.parse(html_doc)
        new(html_doc).parse
      end

      def parse
        @details = {
          personal: {
            record_date: get_personal(0),
            martial_status: get_personal(1),
            birthday: get_personal(2),
            birth_city: get_personal(3),
            birth_place: get_personal(4)
          },

          address: {
            record_date: get_address(0),
            status: get_address(1),
            type: get_address(2),
            address: get_address(3)
          }

        }
      end

      def get_personal(num)
        @html_doc.css('.personal tr td')[num].children[0].text.strip
      end

      def get_address(num)
        @html_doc.css('.addresses tr td')[num].children[0].text.strip
      end
    end
  end
end
