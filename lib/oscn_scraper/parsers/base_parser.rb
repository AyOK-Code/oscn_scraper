require 'nokogiri'
require 'byebug'

module OscnScraper
  module Parsers
    # Builds the objects by parsing the page
    class BaseParser
      attr_reader :parsed_html

      def initialize(parsed_html)
        @parsed_html = parsed_html
      end

      def build_object
        case_object = {}
        [
          OscnScraper::Parsers::Case.new(parsed_html),
          OscnScraper::Parsers::Judge.new(parsed_html),
          OscnScraper::Parsers::Parties.new(parsed_html),
          OscnScraper::Parsers::Events.new(parsed_html),
          OscnScraper::Parsers::Counts.new(parsed_html),
          OscnScraper::Parsers::DocketEvents.new(parsed_html)
        ].each do |p|
          data = p.parse
          case_object.merge!(data)
          puts data
        end
        case_object
      end

      private

      def parse_html(html)
        Nokogiri::HTML(html.body)
      end
    end
  end
end
