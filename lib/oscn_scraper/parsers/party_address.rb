module OscnScraper
  module Parsers
    # Save detailed Party information
    class PartyAddress
      attr_accessor :party
      attr_reader :row

      def initialize(html_row, party_object)
        @row = html_row
        @party = party_object
      end

      def self.perform(row, party)
        new(row, party).perform
      end

      def perform
        address_columns = row.children.css('td')
        return if address_columns.count == 1 # No records found

        return if address_columns[3].text.blank? # Skip if no address information found

        begin
          create_party_address(address_columns)
        rescue StandardError => e
          Raygun.track_exception(e,
                                 custom_data: { error_type: 'Data Error', data_content: address_columns,
                                                oscn_id: party[:oscn_id] })
        end
      end

      def create_party_address(address_columns)
        string = address_string(address_columns)

        {
          record_on: record_on(address_columns[0]),
          status: address_columns[1].text,
          city: city(string),
          state: state(string),
          zip: zip(string),
          address_type: address_columns[2].text
        }
      end

      def record_on(date_html)
        Date.strptime(date_html.text, '%m/%d/%Y')
      end

      def zip(zip_html)
        zip_html[1].split[1].squish.to_i
      rescue NoMethodError
        nil
      end

      def city(city_html)
        if city_html.length == 1
          nil
        else
          city_html[0]
        end
      end

      def address_string(columns)
        columns[3].text.split(',')
      end

      def state(state_html)
        if state_html.length == 1
          state_html[0]
        else

          state_html[1]&.split&.[](0)
        end
      end
    end
  end
end
