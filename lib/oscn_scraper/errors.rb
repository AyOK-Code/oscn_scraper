module OscnScraper
  # Case was not found on OSCN
  class CaseNotFoundError < RuntimeError; end

  # Required required params
  class RequiredParamError < RuntimeError; end

  # Invalid param
  class InvalidParamError < RuntimeError; end
end
