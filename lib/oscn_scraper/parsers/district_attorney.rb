require 'byebug'
module OscnScraper
  module Parsers
    # Parses da_html with Nokogiri and returns it
    class DistrictAttorney
        attr_reader :parsed_html
        attr_accessor :district_attorneys
      def initialize(html)
        @parsed_html= Nokogiri::HTML(html)

    @district_attorneys= []

      end

      def perform
      
       

       parsed_html.css('tr').each_with_index do |d,i| 
        if i == 0
            next
        end

            district_attorneys << district_attorney(d)

       end
       
        district_attorneys

      end

      def  district_attorney(d)
        {
            district: d.children[1].text.squish,
       
            district_attorney: d.children[3].text.squish,
       
            counties: d.children[5].text.split(',').map(&:squish).select(&:present?)
            
         }
         

      end

      


      
    end
  end
end
