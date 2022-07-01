module OscnScraper
  module Parsers
    # parses Party Details and returns object with them
    class PartyDetails
      def initialize(html_doc)
        @html_doc = html_doc
      end

      # why?
      def self.parse(html_doc)
        new(html_doc).parse
      end

      def personal_details
        {
          record_date: get_personal(0),
          martial_status: get_personal(1),
          birthday: get_personal(2),
          birth_city: get_personal(3),
          birth_place: get_personal(4),
          addresses: []
        }
      end

      def address_details
        {
          record_date: nil,
          status: nil,
          type: nil,
          address: nil
        }
      end

      def parse
        party_details = personal_details
        address_rows.each do |a|
          party_details[:addresses] << extract_row(a)
        end

        party_details
      end

      def get_personal(num)
        @html_doc.css('.personal tr td')[num].children[0].text.strip
      end

      def address_rows
        @html_doc.css('.addresses tbody tr')
      end

      def extract_row(row)
        {
          record_date: row.css('td')[0].text.strip,
          status: row.css('td')[1].text.strip,
          type: row.css('td')[2].text.strip,
          address: row.css('td')[3].text.strip
        }
      end
    end
  end
end
