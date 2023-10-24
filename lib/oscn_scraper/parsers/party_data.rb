module OscnScraper
  module Parsers
    # Save detailed Party information
    class PartyData
      # attr_accessor :party

      def initialize(parsed_html)
        # @party = ::Party.find_by!(oscn_id: oscn_id)
      end

      def self.perform(parsed_html)
        new(parsed_html).perform
      end

      # TODO: Move data parsing to the Gem side
      def perform
        # html = party.party_html.html
        # parsed_html = Nokogiri::HTML(html)
        personal_columns = personal_html(parsed_html)
        aliases_column = aliases_html(parsed_html)
        address_row = parsed_html.css('.addresses tr')

        { personal_columns: personal_columns, aliases_column: aliases_column,
          address_row: address_row }
      end

      def personal_html(parsed_html)
        parsed_html.css('.personal tr td')
      end

      def aliases_html(parsed_html)
        parsed_html.css('.partymain tr td')[1].children
      end

      def address_html(parsed_html)
        parsed_html.css('.addresses tr')
      end
    end
  end
end