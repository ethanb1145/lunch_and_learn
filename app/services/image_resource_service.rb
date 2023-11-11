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
    urls = extract_urls(results)
    alt_tags = extract_alt_tags(results)
    
    images_data = alt_tags.first(10).zip(urls.first(10)).map do |alt_tag, url|
      { alt_tag: alt_tag, url: url }
    end

    images_data
  end

  def extract_urls(results)
    results[:photos].map { |photo| photo[:url] }
  end

  def extract_alt_tags(results)
    results[:photos].map { |photo| photo[:alt] }
  end
end