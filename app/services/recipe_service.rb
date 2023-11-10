class RecipeService
  def conn
    Faraday.new(url: "https://api.edamam.com") do |faraday|
      faraday.params["app_id"] = Rails.application.credentials.edamam[:app_id]
      faraday.params["app_key"] = Rails.application.credentials.edamam[:app_key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def recipe_search(country)
    get_url("/api/recipes/v2?type=public&q=#{country}")
  end
end