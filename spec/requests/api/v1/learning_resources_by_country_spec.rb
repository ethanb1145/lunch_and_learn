require "rails_helper"

RSpec.describe "Learning Resources API", type: :request do
  describe "GET /api/v1/learning_resources" do
    it "returns learning resources for a specific country" do
      WebMock.allow_net_connect!
      
      json_data = File.read("spec/fixtures/estonia.json")
      stub_request(:get, "http://localhost:3000/api/v1/learning_resources?country=estonia").to_return(status: 200, body: json_data, headers: {})
      
      get "/api/v1/learning_resources", params: { country: "Estonia" }

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      
      expect(json_response["data"]).to be_a(Hash)
      data = json_response["data"]
      expect(data).to include("id", "type", "attributes")
      expect(data["attributes"]).to include("country", "video", "images")
    end
  end
end