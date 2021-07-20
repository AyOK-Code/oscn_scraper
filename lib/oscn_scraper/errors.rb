module OscnScraper
  # Raise when expected data is not found in DOM node
  class DataNotFoundError < RuntimeError; end

  # Data found does parse as expected
  class InvalidParseError < RuntimeError; end

  # Case was not found on OSCN
  class CaseNotFoundError < RuntimeError; end

  # Missing required params
  class MissingParamError < RuntimeError; end

  # Invalid param
  class InvalidParamError < RuntimeError; end
end
