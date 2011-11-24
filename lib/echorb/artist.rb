require 'httparty'

module Echorb
  class Artist
    include HTTParty

    attr_reader :id, :name

    def initialize id, name
      @id = id
      @name = name
    end

    def self.search name
      search_url = "http://developer.echonest.com/api/v4/artist/search"
      result = get(search_url, :query => { :name => name }, :output => "json")
      result["response"]["artists"]
    end
  end
end
