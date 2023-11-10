require "rails_helper"

RSpec.describe "Learning Resources API", type: :request do
  describe "GET /api/v1/learning_resources" do
    it "returns learning resources for a specific country" do
      get "/api/v1/learning_resources", params: { country: "Laos" }

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response["data"]).to be_an(Array)
      expect(json_response["data"]).to include("id, type, attributes")
      expect(json_response["data"].first["attributes"]).to include("country", "video", "images")
    end
  end
end