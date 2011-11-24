require "echorb/version"
require "echorb/artist"

module Echorb
  API_VERSION = "v4"
  API_ENDPOINT = "http://developer.echonest.com/api/#{API_VERSION}"

  def self.compose_url resource, method
    "#{API_ENDPOINT}/#{resource}/#{method}"
  end
end
