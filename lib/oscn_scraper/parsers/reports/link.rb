module OscnScraper
  module Parsers
    # Parses link data from Reports
    module Reports
      # Initializes class
      class Link
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
          uri = URI.parse(@link_html.at('a')['href'])
          params = CGI.parse(uri.query)
          {

            case_number: @link_html.at('a').text,
            link: @link_html.at('a')['href'].first,
            oscn_id: params['casemasterID'].first.to_i,
            county: params['db'].first
          }
        end
      end
    end
  end
end
