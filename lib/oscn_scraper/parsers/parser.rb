require 'nokogiri'
require 'byebug'

module OscnScraper
  module Parsers
    # Description/Explanation of Parser class
    class Parser < BaseParser
      attr_reader :parsed_html

      def build_object
        # TODO: loop through each parser to build the object
        parsed_html
      end
    end
  end
end
