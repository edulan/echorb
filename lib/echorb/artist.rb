require 'net/http'

module Echorb
  class Artist
    attr_reader :id, :name

    def initialize id, name
      @id = id
      @name = name
    end

    def self.search name
      search_params = { :name => name }
      search_uri = URI("http://developer.echonest.com/api/v4/artist/search")
      search_uri.query = URI.encode_www_form(search_params)

      response = Net::HTTP.get_response(search_uri)
      result = JSON.parse(response.body)
      result["response"]["artists"]
    end
  end
end
