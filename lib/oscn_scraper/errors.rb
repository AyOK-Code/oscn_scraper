module OscnScraper
  # Raise when expected data is not found in DOM node
  class DataNotFound < RuntimeError; end

  # Data found does parse as expected
  class InvalidParse < RuntimeError; end

  # Case was not found on OSCN
  class CaseNotFound < RuntimeError; end
end
