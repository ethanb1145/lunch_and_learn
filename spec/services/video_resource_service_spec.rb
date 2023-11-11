require "rails_helper"

RSpec.describe VideoResourceService do 
  before(:each) do 
    @service = VideoResourceService.new
  end

  describe "#video_resource" do
    it "should return results based off a country" do
      resource = @service.video_resource("estonia")
      expect(resource[:title]).to eq("A Super Quick History of Estonia")
      expect(resource[:youtube_video_id]).to eq("pKhdxYGw83I")
    end
  end
end