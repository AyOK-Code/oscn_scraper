module OscnScraper
  # Description/Explanation of BaseParser class
  class BaseParser
    def initialize(html)
      @parsed_html = Nokogiri::HTML(html)
    end
    # TODO: This class will include error handling and helper methods for the parsers
  end
end
