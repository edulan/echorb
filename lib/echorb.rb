require "echorb/version"
require "echorb/client"

def Echorb(api_key)
  Echorb::Client.new(api_key)
end

module Echorb
  class Error < RuntimeError
    attr_reader :code

    def initialize(code)
      @code = code
    end
  end

  class UnknownError < Echorb::Error; end
  class InvalidAPIKeyError < Echorb::Error; end
  class UnauthorizedAPIKeyError < Echorb::Error; end
  class RateLimitError < Echorb::Error; end
  class MissingParamError < Echorb::Error; end
  class InvalidParamError < Echorb::Error; end

  class ErrorFactory
    def self.create(code)
      klass = case code
      when -1 then Echorb::UnknownError
      when  1 then Echorb::InvalidAPIKeyError
      when  2 then Echorb::UnauthorizedAPIKeyError
      when  3 then Echorb::RateLimitError
      when  4 then Echorb::MissingParamError
      when  5 then Echorb::InvalidParamError
      end

      klass.new(code)
    end
  end
end
