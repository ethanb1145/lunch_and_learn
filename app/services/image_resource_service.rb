class ImageResourceService
  def conn
    Faraday.new(url: "")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

end