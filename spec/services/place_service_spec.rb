require "rails_helper"

RSpec.describe PlaceService do
  describe "#get_tourist_sites" do
    it "returns tourist sites for a given latitude and longitude" do
      json_data = File.read("spec/fixtures/paris_sites.json")

      stub_request(:get, "https://api.geoapify.com/v2/places?apiKey=#{Rails.application.credentials.places[:key]}&categories=tourism.sights&filter=circle:48.8566,2.3522,10000").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.7.11'
           }).
         to_return(status: 200, body: json_data, headers: {})

      service = PlaceService.new
      response = service.get_tourist_sites(2.3522, 48.8566)

      expected_keys = [:type, :features]
      expect(response.keys).to eq(expected_keys)
      expect(response[:features].first.keys).to include(:type, :properties, :geometry)
      expect(response[:features].first[:properties].keys).to include(:name, :country, :country_code, :region, :state, :city, :postcode)
    end
  end
end