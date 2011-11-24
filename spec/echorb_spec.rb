$:.unshift(File.dirname(__FILE__))
require 'spec_helper'

describe "Echorb" do
  it "has an api version number" do
    Echorb::API_VERSION.should_not be_nil
  end

  it "has an api endpoint url" do
    Echorb::API_ENDPOINT.should_not be_nil
  end

  describe ".compose_url" do
    before :each do
      @url = Echorb.compose_url "artist", "search"
    end

    it "generates a valid echonest resurce url" do
      @url.should =~ /#{Echorb::API_ENDPOINT}\/artist\/search/
    end
  end
end
