require "spec_helper"
require "net/http/post/multipart"

module Echorb
  describe Client do
    before do
      @api_key = "N6E4NIOVYMTHNDM8J"
      @client = Client.new(@api_key)
    end

    describe "#catalog_create" do
      before do
        @post_request = Net::HTTP::Post.new "/"
        @post_params = {:name => "Catalog", :type => "artist", :api_key => @api_key}

        stub_post("/catalog/create").
            with(:body => @post_params).
            to_return(:status => 201, :body => fixture("catalog/create.json"),
              :headers => {:content_type => "application/json; charset=utf-8"})       
      end

      it "requests the correct resource" do
        @client.catalog_create(:name => "Catalog", :type => :artist)

        a_post("/catalog/create").
          with(:body => @post_params).
          should have_been_made
      end

      it "returns a new catalog" do
        catalog = @client.catalog_create(:name => "Catalog", :type => :artist)

        catalog.should be_a_kind_of(Echorb::Catalog)
      end
    end

    describe "#catalog_update" do
      before do
        @items = [
          {
            "action" => "update",
            "item" => {
              "item_id" => "royk",
              "artist_name" => "Royksopp"
            }
          },
          {
            "action" => "update",
            "item" => {
              "item_id" => "itsgucci",
              "artist_name" => "Gucci Mane"
            }
          }
        ]
        @post_request = Net::HTTP::Post::Multipart.new "/", {:id => "CAPWAHG1384F8969E9", :data => @items, :api_key => @api_key}
        @post_body = @post_request.body_stream.read

        stub_post("/catalog/update").
            with(:body => @post_body).
            to_return(:status => 200, :body => fixture("catalog/update.json"),
              :headers => {:content_type => "application/json; charset=utf-8"})   
      end

      it "requests the correct resource" do
        @client.catalog_update(:id => "CAPWAHG1384F8969E9", :data => @items)

        a_post("/catalog/update").
          with(:body => @post_body).
          should have_been_made
      end

      it "returns a ticket id associated with update process" do
        catalog = @client.catalog_update(:id => "CAPWAHG1384F8969E9", :data => @items)

        catalog.should be_a_kind_of(Echorb::Catalog)
        catalog.ticket.should_not be_nil
      end
    end

    describe "#catalog_status" do
      before do
        stub_get("/catalog/status").
            with(:query => {:ticket => "e0ba094bbf98cd006283aa7de6780a83", :api_key => @api_key}).
            to_return(:status => 200, :body => fixture("catalog/status.json"),
              :headers => {:content_type => "application/json; charset=utf-8"}) 
      end

      it "requests the correct resource" do
        @client.catalog_status(:ticket => "e0ba094bbf98cd006283aa7de6780a83")

        a_get("/catalog/status").
          with(:query => {:ticket => "e0ba094bbf98cd006283aa7de6780a83", :api_key => @api_key}).
          should have_been_made
      end

      it "returns a ticket representing the catalog status" do
        catalog = @client.catalog_status(:ticket => "e0ba094bbf98cd006283aa7de6780a83")

        catalog.should be_a_kind_of(Echorb::Ticket)
        catalog.ticket_status.should == "complete"
      end
    end
  end
end