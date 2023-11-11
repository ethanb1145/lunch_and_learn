require "rails_helper"

RSpec.describe CountryService do 
  before(:each) do 
    @service = CountryService.new
  end

  describe "#countries" do
    it "should return countries" do
      json_data = File.read("spec/fixtures/countries.json")
      stub_request(:get, "https://restcountries.com/v3.1/all").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'Faraday v2.7.11'
           }).
         to_return(status: 200, body: json_data, headers: {})
         
      countries = @service.countries
      countries.each do |country|
        expect(country[:name]).to have_key(:common)
      end
    end
  end
end