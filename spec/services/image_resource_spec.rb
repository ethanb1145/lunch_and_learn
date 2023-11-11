require "rails_helper"

RSpec.describe ImageResourceService do 
  before(:each) do 
    @service = ImageResourceService.new
  end

  it "should have a URL for each image" do
    estonia_response = @service.images("estonia")
    image = estonia_response[2][1].first
    expect(image[:url]).to eq("https://www.pexels.com/photo/white-and-brown-concrete-building-1803860/")
  end
end