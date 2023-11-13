class VideoResourceService
  def conn
    Faraday.new(url: "https://youtube.googleapis.com") do |faraday|
      faraday.params["key"] = Rails.application.credentials.google[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def video_resource(country)
    results = get_url("/youtube/v3/search?part=snippet&channelId=UCluQ5yInbeAkkeCndNnUhpw")
    video = results[:items]&.find do |item|
      item[:snippet][:title].downcase.include?(country.downcase)
    end
    
    if video
      {
        title: video[:snippet][:title],
        youtube_video_id: video[:id][:videoId]
      }
    else
      nil
    end
  end
end