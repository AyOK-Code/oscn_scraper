require 'nokogiri'
require 'active_support/core_ext/string'

module OscnScraper
  module Parsers
    # Builds the objects by parsing the page
    class BaseParser
      attr_reader :parsed_html
      attr_accessor :case_object

      # Initializes the object
      #
      # @param parsed_html [Html] Parsed Html from CaseInformation endpoint
      # @return case_object [Array] Full case
      def initialize(parsed_html)
        @parsed_html = parsed_html
        @case_object = {}
      end

      def build_object
        return OscnScraper::Errors::CaseNotFound if error?

        [
          OscnScraper::Parsers::Case,
          OscnScraper::Parsers::Judge,
          OscnScraper::Parsers::Attorney,
          OscnScraper::Parsers::Parties,
          OscnScraper::Parsers::Events,
          OscnScraper::Parsers::Counts,
          OscnScraper::Parsers::DocketEvents
        ].each do |parser|
          parse_object(parser)
        end
        case_object
      end

      def parse_object(parser)
        name = parser.name.split('::').last
        html_method = "#{name.underscore}_html"
        html = send(html_method)
        data = parser.parse(html)

        begin
          case_object.merge!(data)
        rescue OscnScraper::Errors::InvalidParse => e
          puts "#{e}: Something went wrong parsing #{name}"
        end
      end

      private

      def parse_html(html)
        Nokogiri::HTML(html.body)
      end

      def error?
        error_html.count.positive?
      end

      def error_html
        parsed_html.css('.errorMessage')
      end

      def case_html
        parsed_html.css('table').first.css('td')[1]
      end

      def judge_html
        parsed_html.at('td:contains("Judge:")')
      end

      def attorney_html
        parsed_html.xpath('//h2[contains(@class, "attorneys")]/following-sibling::*[1]')
      end

      def parties_html
        parsed_html.xpath('//h2[contains(@class, "party")]/following-sibling::p[1]')
      end

      def events_html
        parsed_html.xpath('//h2[contains(@class, "events")]/following-sibling::*[1]')
      end

      def counts_html
        parsed_html.css('div.CountsContainer')
      end

      def docket_events_html
        parsed_html.xpath('//h2[contains(@class, "docket")]/following-sibling::*[1]')
      end
    end
  end
end
