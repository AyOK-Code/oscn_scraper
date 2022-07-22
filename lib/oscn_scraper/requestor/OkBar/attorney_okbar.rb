module OscnScraper
  module Requestor
    module OkBar
      # Searches for ok bar attorneys
      # @note base url - 'https://www.okbar.org/oba-member-search/?'
      class AttorneyOkBar
        # Initialize the class
        #
        # @param state_abreviation [String] Name of State
        # @param pagenum [Integer] page number of site

        def initialize(state_abreviation = 'OK', pagenum = 1)
          @base_url = 'https://www.okbar.org/oba-member-search/?'
          @state_abreviation = state_abreviation
          @pagenum = pagenum
        end

        # Class method to call perform
        def self.perform(state_abreviation = 'OK', pagenum = 1)
          new(state_abreviation, pagenum).perform
        end

        # Makes request to OSCN
        #
        # @return Request data
        def perform
          url = "pagenum=#{@pagenum}&sort%5B5%5D=desc&filter_11=#{@state_abreviation}&mode=all"
          full_url = @base_url + url

          html = URI.parse(full_url).open # "#{base_url}#{url}"

          Nokogiri::HTML(html)
        end
      end
    end
  end
end
