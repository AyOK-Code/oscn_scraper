module OscnScraper
  module Parsers
    # A place to take the html and make it easier
    module Helpers
      def sanitize_data(html)
        html&.text&.squish
      end

      def parse_date(date)
      return nil if date.nil?

        Date.strptime(date, '%m/%d/%Y')
      rescue Date::Error
        nil
      end
    end
  end
end
