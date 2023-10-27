module OscnScraper
  module Parsers
    # Parses Attorney data from the case
    class Attorney
      attr_reader :attorney_html

      # Initializes class
      #
      # @param attorney_html [Html] From the Attorney section of the CaseInformation endpoint
      # @return Class object
      def initialize(attorney_html)
        @attorney_html = attorney_html
        @attorneys = { attorneys: [] }
      end

      # Class method to call .parse
      # @param attorney_html [Html]
      # @return attorneys [Array]
      def self.parse(attorney_html)
        new(attorney_html).parse
      end

      # TODO: Drop this method?
      def parse
        parse_attorney
      end

      private

      attr_accessor :attorneys

      def parse_attorney
        return attorneys if attorney_html.blank?

        attorney_html.css('tbody tr').each do |a|
          column_one = a.css('td')[0].children[0].text
          name = parse_name(column_one)
          bar_number = parse_bar_number(column_one)
          address = parse_address(a)
          all_parties = a.css('td')[1].children.select { |e| e.node_name == 'text' }
          attorneys[:attorneys] << {
            name: name,
            address: address,
            bar_number: bar_number,
            represented_parties: all_parties.map { |e| parse_parties(e) }
          }
        end
        attorneys
      end

      def parse_name(text)
       
        text.split('(')[0]&.squish
      end

      def parse_bar_number(text)
        # TODO: Change to regex
        begin
        text.split('(')[1].split('#')[1].gsub(')', '')
      rescue NoMethodError => e
        # TODO: Log unparsible bar number
        Raygun.track_exception(e,
        custom_data: { error_type: 'Data Error', data_content: text })
        return nil
      end
      end

      def parse_address(attorney)
        begin
        attorney.css('td')[0].children[1..].inner_html
      rescue NoMethodError
        return nil
      end
      end

      def parse_parties(element)
        begin
        element.text
        rescue NoMethodError
          return nil
        end

      end
    end
  end
end
