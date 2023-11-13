class PlaceService
  def conn
    Faraday.new(url: "https://api.geoapify.com") do |faraday|
      faraday.params["apiKey"] = Rails.application.credentials.places[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_tourist_sites(latitude, longitude)
    get_url("/v2/places?categories=tourism.sights&filter=circle:#{longitude},#{latitude},10000")
  end
end