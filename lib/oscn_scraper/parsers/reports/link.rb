module OscnScraper
  module Parsers
    # Parses link data from Reports
    module Reports
      class Link
        # Initializes class
        #
        # @param link_html [Html] From the Attorney section of the CaseInformation endpoint
        # @return Class object
        def initialize(link_html)
          @link_html = link_html
        end

        # Class method to call .parse
        # @param link_html [Html]
        # @return link [Object]
        def self.parse(link_html)
          new(link_html).parse
        end

        def parse
          parse_link
        end

        private

        def parse_link
          #TODO: Your code goes here
        end
      end
    end
  end
end
