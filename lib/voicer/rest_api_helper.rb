# frozen_string_literal: true

require "json"
require "net/http"

module Voicer
  class ParseKanaBadRequest < Net::HTTPClientException; end

  class HTTPValidationError < Net::HTTPClientException; end

  module RestApiHelper
    def build_uri(path, **query)
      uri = URI(path)
      uri.query = URI.encode_www_form(query) unless query.empty?
      uri.to_s
    end
    private :build_uri

    def verify_response_code(response)
      case response.code
      when "400"
        raise ParseKanaBadRequest.new(response.body, response)
      when "422"
        raise HTTPValidationError.new(response.body, response)
      else
        response.value
      end
      response
    end
    private :verify_response_code
  end
end
