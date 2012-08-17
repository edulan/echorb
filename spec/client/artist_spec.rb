require "spec_helper"

module Echorb
  describe Client do
    before do
      @api_key = "N6E4NIOVYMTHNDM8J"
      @client = Client.new(@api_key)
    end

    describe "#artist_search" do
      before do
        stub_get("/artist/search").
            with(:query => {:name => "Radiohead", :api_key => @api_key}).
            to_return(:status => 200, :body => fixture("artist/search.json"),
              :headers => {:content_type => "application/json; charset=utf-8"})        
      end

      it "requests the correct resource" do
        @client.artist_search(:name => "Radiohead")

        a_get("/artist/search").
          with(:query => {:name => "Radiohead", :api_key => @api_key}).
          should have_been_made
      end

      it "returns matched artists" do
        artists = @client.artist_search(:name => "Radiohead")

        artists.should have(1).artist
      end
    end

    describe "#artist_similar" do
      before do
        stub_get("/artist/similar").
            with(:query => {:id => "ARH6W4X1187B99274F", :api_key => @api_key}).
            to_return(:status => 200, :body => fixture("artist/similar.json"),
              :headers => {:content_type => "application/json; charset=utf-8"})        
      end

      it "requests the correct resource" do
        @client.artist_similar(:id => "ARH6W4X1187B99274F")

        a_get("/artist/similar").
          with(:query => {:id => "ARH6W4X1187B99274F", :api_key => @api_key}).
          should have_been_made
      end

      it "returns similar artists" do
        artists = @client.artist_similar(:id => "ARH6W4X1187B99274F")

        artists.should have(1).artist
      end
    end
  end
end