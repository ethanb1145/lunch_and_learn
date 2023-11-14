class RecipesFacade
  def initialize(params)
    @country = params[:country].presence || random_country
  end

  def recipes
    recipes = RecipeService.new.recipe_search(@country)

    if recipes.present? && recipes[:hits].present?
      serialize_recipes(recipes)
    else
      []
    end
  end

  private

  def random_country
    country_service = CountryService.new
    countries = country_service.countries

    country_names = countries.map { |country| country[:name][:common] }
    country_names.sample 
  end

  def serialize_recipes(recipes)
    recipes[:hits].map do |recipe|
      {
        id: nil,
        type: "recipe",
        attributes: {
          title: recipe[:recipe][:label],
          url: recipe[:recipe][:url],
          country: @country,
          image: recipe[:recipe][:image]
        }
      }
    end
  end
end