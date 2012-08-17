require "json"
require "spec_helper"

module Echorb
  describe Client do
    before do
      @api_key = "N6E4NIOVYMTHNDM8J"
      @client = Client.new(@api_key)
    end

    describe "#prepare_params" do
      it "converts key-value pair to array param" do
        array_params = @client.prepare_params(:name => "Radiohead")
        first_param = array_params.first

        array_params.should be_a_kind_of(Array)
        first_param.should be_a_kind_of(Array)
        first_param[0].should == :name
        first_param[1].should == "Radiohead"
      end

      it "converts bucket array to bucket params" do
        params = {:bucket => [:id, :name, :hotttnesss]}

        @client.prepare_params(params).should have(3).buckets
      end
    end

    describe "#parse_response" do
      it "returns a json representation of the response" do
        response = {:response => {:status => {:code => 0, :message => "Success"}}}
        json_reponse = response.to_json

        @client.parse_response(json_reponse).should == response[:response]
      end

      context "when no API key was supplied" do
        before do
          @response = {:response => {:status => {:code => 1, :message => "Missing API key"}}}.to_json
        end

        it "raises an InvalidAPIKeyError error" do
          expect { @client.parse_response(@response) }.to raise_error(Echorb::InvalidAPIKeyError, "Missing API key") { |error| error.code.should == 1 }
        end
      end

      context "when calling an unauthorized API method" do
        before do
          @response = {:response => {:status => {:code => 2, :message => "Unauthorized API key"}}}.to_json
        end

        it "raises an UnauthorizedAPIKeyError error" do
          expect { @client.parse_response(@response) }.to raise_error(Echorb::UnauthorizedAPIKeyError, "Unauthorized API key") { |error| error.code.should == 2 }
        end
      end

      context "when API rate limit was exceeded" do
        before do
          @response = {:response => {:status => {:code => 3, :message => "Rate limit exceeded"}}}.to_json
        end

        it "raises a RateLimitError error" do
          expect { @client.parse_response(@response) }.to raise_error(Echorb::RateLimitError, "Rate limit exceeded") { |error| error.code.should == 3 }
        end
      end

      context "when a required parameter is missing" do
        before do
          @response = {:response => {:status => {:code => 4, :message => "Missing parameter"}}}.to_json
        end

        it "raises a MissingParamError error" do
          expect { @client.parse_response(@response) }.to raise_error(Echorb::MissingParamError, "Missing parameter") { |error| error.code.should == 4}
        end
      end

      context "when an invalid parameter was supplied" do
        before do
          @response = {:response => {:status => {:code => 5, :message => "Invalid parameter"}}}.to_json
        end

        it "raises an InvalidParamError error" do
          expect { @client.parse_response(@response) }.to raise_error(Echorb::InvalidParamError, "Invalid parameter") { |error| error.code.should == 5}
        end
      end

      context "when an unknown error ocurred" do
        before do
          @response = {:response => {:status => {:code => -1, :message => "Unknown error"}}}.to_json
        end

        it "raises an UnknownError error" do
          expect { @client.parse_response(@response) }.to raise_error(Echorb::UnknownError, "Unknown error") { |error| error.code.should == -1}
        end
      end
    end
  end
end