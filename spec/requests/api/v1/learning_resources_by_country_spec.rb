require "rails_helper"

RSpec.describe "Learning Resources API", type: :request do
  describe "GET /api/v1/learning_resources" do
    it "returns learning resources for a specific country" do
      WebMock.allow_net_connect!
      json_data = File.read("spec/fixtures/estonia.json")
      stub_request(:get, "http.localhost:3000/api/v1/learning_resources?country=estonia").to_return(status: 200, body: json_data, headers: {})
      get "/api/v1/learning_resources", params: { country: "Estonia" }

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      
      expect(json_response["data"]).to be_an(Hash)
      
      expect(json_response).to eq({
        "data" => {
          "id" => nil,
          "type" => "learning_resource",
          "attributes" => {
            "country" => "Estonia",
            "video" => {
              "title" => "A Super Quick History of Estonia",
              "youtube_video_id" => "pKhdxYGw83I"
            },
            "images" => [
              { "alt_tag" => "White and Brown Concrete Building", "url" => "https://www.pexels.com/photo/white-and-brown-concrete-building-1803860/" },
              { "alt_tag" => "Photo of Castle Exterior", "url" => "https://www.pexels.com/photo/photo-of-castle-exterior-3224113/" },
              { "alt_tag" => "Body of Water", "url" => "https://www.pexels.com/photo/body-of-water-2177955/" },
              { "alt_tag" => "White and Brown Concrete Building", "url" => "https://www.pexels.com/photo/white-and-brown-concrete-building-1803859/" },
              { "alt_tag" => "White and Brown Concrete Building", "url" => "https://www.pexels.com/photo/white-and-brown-concrete-building-1803858/" },
              { "alt_tag" => "Brown Deer on Green Grass Field", "url" => "https://www.pexels.com/photo/brown-deer-on-green-grass-field-3732496/" },
              { "alt_tag" => "Low Angle Photo of High-rise Building", "url" => "https://www.pexels.com/photo/low-angle-photo-of-high-rise-building-1140989/" },
              { "alt_tag" => "", "url" => "https://www.pexels.com/photo/facades-along-square-in-tallin-18864573/" },
              { "alt_tag" => "Close Up Photo of Text on Brown Paper", "url" => "https://www.pexels.com/photo/close-up-photo-of-text-on-brown-paper-6957221/" },
              { "alt_tag" => "Man In Black Wetsuit", "url" => "https://www.pexels.com/photo/man-in-black-wetsuit-1109078/" }
            ]
          }
        }
      })
    end
  end
end