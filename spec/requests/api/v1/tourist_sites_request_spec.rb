require "rails_helper"

RSpec.describe "Tourist Sites API", type: :request do
  describe "GET /api/v1/tourist_sites" do
    it "returns a successful response with serialized tourist sites for a valid country" do
      json_data = File.read("spec/fixtures/tourist_sites_france.json")
      stub_request(:get, "http://localhost:3000/api/v1/tourist_sites?country=France").
      to_return(status: 200, body: json_data, headers: { 'Content-Type' => 'application/json' })

      get "/api/v1/tourist_sites", params: { country: "France" }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)

      expect(json_response).to eq(JSON.parse(json_data))
    end

    it "returns a empty array if country does not have any data" do
      country = "Antarctica"
      WebMock.allow_net_connect!

      get "/api/v1/tourist_sites", params: { country: country }

      json_response = JSON.parse(response.body)

      expect(json_response["data"]).to eq([])
    end
  end
end