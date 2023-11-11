class ImageResourceService
  def conn
    Faraday.new(url: "https://api.pexels.com") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.pexels[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def images(country)
    results = get_url("v1/search?query=#{country}")
    results.first(10)
  end
end