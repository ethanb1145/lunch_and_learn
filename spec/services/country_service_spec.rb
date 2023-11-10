require "rails_helper"

RSpec.describe CountryService do 
  before(:each) do 
    @service = CountryService.new
  end

  describe "#countries" do
    it "should return countries" do
      countries = @service.countries
      countries.each do |country|
        expect(country[:name]).to have_key(:common)
      end
    end
  end
end