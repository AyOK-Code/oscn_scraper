module OscnScraper
  module Requestor
    # Srapes data from a report endpoint on OSCN
    class Report < Base
      def initialize(kwargs = {})
        @kwargs = kwargs
      end

      def fetch_daily_filings(date)
        params = {
          report: 'DailyFilings',
          errorcheck: true,
          db: 'Oklahoma',
          StartDate: date
        }
        request(concatenated_url(endpoint, params))
      end

      def events_scheduled(county, case_type_id, date)
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
