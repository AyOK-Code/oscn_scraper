module OscnScraper
  module Parsers
    # Parses link data from Reports
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

      attr_accessor :link_html

      def parse_link
        uri = URI.parse(link_html['href'])
        params = CGI.parse(uri.query)
        param_keys = params.map { |k, _v| k }
        param_diff = required_params(params) - param_keys
        if param_diff.count.positive?
          raise OscnScraper::Errors::RequiredParam,
                "Missing Param: #{param_diff.join(', ')}"
        end

        {
          case_number: case_number(params),
          link: link_html['href'],
          oscn_id: oscn_id(params),
          county: params['db'].first
        }
      end

      def required_params(params)
        if params['casemasterID'].present?
          %w[casemasterID db]
        else
          %w[cmid db number]
        end
      end

      def case_number(params)
        if params['casemasterID'].present?
          link_html.text
        else
          params['number'].first
        end
      end

      def oscn_id(params)
        if params['casemasterID'].present?
          params['casemasterID'].first.to_i
        else
          params['cmid'].first.to_i
        end
      end
    end
  end
end
