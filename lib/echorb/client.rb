require "echorb/artist"
require "echorb/catalog"
require "echorb/playlist"
require "echorb/ticket"
require "json"
require "net/http"
require "net/http/post/multipart"
require "uri"

module Echorb
  class Client
    API_ENDPOINT = "developer.echonest.com"

    def initialize(api_key)
      @api_key = api_key
    end

    def artist_search(options={})
      params = options.merge(:api_key => @api_key)
      response = get("/api/v4/artist/search", params)
      collection_from_array(response[:artists], Echorb::Artist)
    end

    def artist_similar(options={})
      params = options.merge(:api_key => @api_key)
      response = get("/api/v4/artist/similar", params)
      collection_from_array(response[:artists], Echorb::Artist)
    end

    def catalog_profile
    end

    def catalog_create(options={})
      params = options.merge(:api_key => @api_key)
      response = post("/api/v4/catalog/create", params, :type => :form)
      Echorb::Catalog.from_response(response)
    end

    def catalog_update(options={})
      params = options.merge(:api_key => @api_key)
      response = post("/api/v4/catalog/update", params, :type => :multipart)
      Echorb::Catalog.from_response(response)
    end

    def catalog_destroy
    end

    def playlist_create(options={})
      params = options.merge(:api_key => @api_key)
      response = get("/api/v4/playlist/static", params)
      Echorb::Playlist.from_response(response)
    end

    def catalog_status(options={})
      params = options.merge(:api_key => @api_key)
      response = get("/api/v4/catalog/status", params)
      Echorb::Ticket.from_response(response)
    end

    #private

    def get(path, params={}, options={})
      request(:get, path, params, options)
    end

    def post(path, params={}, options={})
      request(:post, path, params, options)
    end

    def collection_from_array(array, klass)
      array.map do |item|
        klass.new(item)
      end
    end

    # Performs HTTP requests and parses results
    def request(method, path, params, options)
      params2 = prepare_params(params)
      url = URI::HTTP.build({:host => API_ENDPOINT, :path => path,
        :query => URI.encode_www_form(params2)})

      case method
      when :get
        req = Net::HTTP::Get.new url.request_uri
      when :post
        case options[:type]
        when :form
          req = Net::HTTP::Post.new url.path
          req.form_data = params
        when :multipart
          req = Net::HTTP::Post::Multipart.new url.path, params
        else
          # TODO: Revise
          req = Net::HTTP::Post.new url.request_uri
        end
      end

      res = Net::HTTP.start(url.host, url.port) do |http|
        http.request(req)
      end

      parse_response(res.body)
    end

    def prepare_params(params)
      params.to_a.inject([]) do |memo, param|
        key, value = param

        if value.kind_of?(Array)
          memo += value.collect { |v| [key, v] }
        else
          memo << param
        end
      end
    end

    def parse_response(body)
      begin
        json_body = JSON.parse(body, :symbolize_names => true)
      rescue JSON::ParserError => e
        # TODO: Implement
      end

      status = json_body[:response][:status]

      raise Echorb::ErrorFactory.create(status[:code]), status[:message] unless status[:code] == 0

      json_body[:response]
    end
  end
end