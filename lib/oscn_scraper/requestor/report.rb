module OscnScraper
  module Requestor
    # Searches reports on OSCN
    # @note OSCN Endpoint - https:://www.oscn.net/applications/oscn/report.asp?
    class Report < Base

      # Initialize the class
      #
      # @param [Hash] kwargs
      # @option kwargs [String] :db Name of Oklahoma County
      # @option kwargs [Date] :date Date for report
      # @option kwargs [CaseTypeID] :case_type_id OSCN ID for the case type
      # @return Request data
      def initialize(kwargs = {})
        @kwargs = kwargs
      end

      # Makes request to OSCN for the cases filed on a given date
      #
      # @param param_name [data_type]
      # @return Request response
      def fetch_daily_filings(date)
        # valid_params?
        params = {
          report: 'DailyFilings',
          errorcheck: true,
          db: 'Oklahoma',
          StartDate: date
        }
        request(concatenated_url(endpoint, params))
      end

      # Makes request to OSCN for cases that are in the docket for a given date and Case Type
      #
      # @param county [String]
      # @param case_type_id [Integer]
      # @param date [Date]
      # @return Request response
      def events_scheduled(county, case_type_id, date)
        # valid_params?
        params = {
          errorcheck: true,
          db: county,
          CaseTypeID: case_type_id.to_s,
          StartDate: date,
          GeneralNumber: 1,
          generalnumber1: 1,
          report: 'WebJudicialDocketCaseTypeAll'
        }
        request(concatenated_url(endpoint, params))
      end

      private

      def endpoint
        'applications/oscn/report.asp?'
      end
    end
  end
end
