require "rails_helper"

RSpec.describe VideoResourceService do 
  before(:each) do 
    @service = VideoResourceService.new
  end

  describe "#video_resource" do
    it "should return results based off a country" do
      json_data = File.read("spec/fixtures/videos.json")
      stub_request(:get, "https://youtube.googleapis.com/youtube/v3/search?channelId=UCluQ5yInbeAkkeCndNnUhpw&key=#{Rails.application.credentials.google[:key]}&part=snippet").
      with(
        headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v2.7.11'
        }).
      to_return(status: 200, body: json_data, headers: {})

      resource = @service.video_resource("estonia")
      expect(resource[:title]).to eq("A Super Quick History of Estonia")
      expect(resource[:youtube_video_id]).to eq("pKhdxYGw83I")
    end
  end
end