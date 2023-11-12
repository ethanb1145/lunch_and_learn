require "rails_helper"

RSpec.describe "Recipes API", type: :request do
  describe "GET /api/v1/recipes" do
    it "returns recipes for a specific country" do
      WebMock.allow_net_connect!

      get "/api/v1/recipes", params: { country: "Thailand" }

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response["data"]).to be_an(Array)
      data = json_response["data"].first
      expect(data["attributes"]).to include("title", "url", "country", "image")
    end

    it "returns recipes for a random country if none is provided" do
      get "/api/v1/recipes"

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response["data"]).to be_an(Array)
      expect(json_response["data"].first["attributes"]).to include("title", "url", "country", "image")
    end

    it "returns an empty array if the country parameter is empty or a value that does not return any recipes" do
      get "/api/v1/recipes", params: { country: "#+==_-=-" }

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response["data"]).to eq([])
    end
  end
end