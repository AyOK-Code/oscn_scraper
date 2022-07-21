require 'byebug'
module OscnScraper
  module Parsers
    # Parses da_html with Nokogiri and returns it
    class DistrictAttorney
      attr_reader :parsed_html
      attr_accessor :district_attorneys

      def initialize(html)
        @parsed_html = Nokogiri::HTML(html)

        @district_attorneys = []
      end

      def perform
        parsed_html.css('tr').each_with_index do |d, i|
          next if i.zero?

          district_attorneys << district_attorney(d)
        end

        district_attorneys
      end

      def district_attorney(dist)
        counts = dist.children[5].text.split(',').map(&:squish).select(&:present?)
        counts.map! do |county|
      case county
      when 'Cimmarron'
        'Cimarron'
      when 'LeFlore'
        'Le Flore'
      else
        county
      end
    end

        {
          district: dist.children[1].text.squish,

          district_attorney: dist.children[3].text.squish,

          counties: counts
        }
      end
    end
  end
end
