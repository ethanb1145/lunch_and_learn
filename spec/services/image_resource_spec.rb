require "rails_helper"

RSpec.describe ImageResourceService do 
  before(:each) do 
    @service = ImageResourceService.new
  end

  it "should return images for a country" do
    json_data = File.read("spec/fixtures/images.json")
    stub_request(:get, "https://api.pexels.com/v1/search?query=estonia").
    with(
      headers: {
      "Accept"=>"*/*",
      "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Authorization"=>"#{Rails.application.credentials.pexels[:key]}",
      "User-Agent"=>"Faraday v2.7.11"
      }).
    to_return(status: 200, body: json_data, headers: {})

    images = ImageResourceService.new.images("estonia")
  end
end