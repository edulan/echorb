$:.unshift(File.dirname(__FILE__))
require 'spec_helper'

module Echorb
  describe Artist do
    before do
      @artist = Artist.new 1, "Radiohead"
    end

    describe "#id" do
      it "returns the artist id" do
        @artist.id.should == 1
      end
    end

    describe "#name" do
      it "returns the artist name" do
        @artist.name.should == "Radiohead"
      end
    end

    describe ".search" do
      context "with a succeed response" do
        before do
          name = "radiohead"
          url = "http://developer.echonest.com/api/v4/artist/search"
          params = { :name => name }
          body = "{\"response\":{\"status\":{\"version\":\"4.2\",\"code\":0,\"message\":\"Success\"},\"artists\":[{\"name\":\"Radiohead\",\"id\":\"ARH6W4X1187B99274F\"}]}}"

          @request = stub_request(:get, url).
            with(:query => params).
            to_return(:headers => { "Content-Type" => "application/json" },
                       :body => body)

          @artists = Artist.search name
        end

        it "searchs for echonest artists" do
          @request.should have_been_requested
        end

        it "returns matched artists" do
          @artists.should have(1).artist
        end
      end
    end
  end
end
